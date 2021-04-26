//
//  ViewController.swift
//  IKEAPlaceDemo
//
//  Created by nermin on 24/04/2021.
//

import UIKit
import SceneKit
import ARKit

class SceneViewController: UIViewController {

    @IBOutlet weak var activeFurniture: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    
    private let furnitureService = FurnitureService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSceneView()
        initARSession()
        initGestureRecognizers()
    }
    
    private func initSceneView() {
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.showsStatistics = true
        sceneView.preferredFramesPerSecond = 60
        sceneView.debugOptions = [.showFeaturePoints]
    }
    
    private func initARSession () {
        
        // Check if the device supports AR
        guard ARWorldTrackingConfiguration.isSupported else {
          print("*** ARConfig: AR World Tracking Not Supported")
          return
        }

        // Define configuration
        let config = ARWorldTrackingConfiguration()
        
        // We want the alignment and origin to be based on .gravity model
        config.worldAlignment = .gravity
        
        // We only want to detect horizonal planes
        config.planeDetection = [.horizontal]
        
        // We want ARKit to take into account light in the room so the models look more natural
        config.isLightEstimationEnabled = true
        
        config.environmentTexturing = .automatic
        
        // Apply the configuration
        sceneView.session.run(config)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let furniture = furnitureService.getActiveFurnitureFromLocalStorage() {
            activeFurniture.text = furniture.name
        }
    }
    
    func initGestureRecognizers() {
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnScreen))
      sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func didTapOnScreen(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sceneView)
        guard let query = sceneView.raycastQuery(from: location, allowing: .existingPlaneInfinite, alignment: .any) else {
           return
        }
                
        let results = sceneView.session.raycast(query)
        guard let hitTestResult = results.first else {
           return
        }
        
        addFurniture(at: hitTestResult)
    }
}

extension SceneViewController: ARSCNViewDelegate{
    
    // This function gets called automatically each time tracking stauts in ARKit changes
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
           print("AR tracking isn’t available.")
        case .normal:
            print("All good")
        case .limited(let reason):
          switch reason {
          case .excessiveMotion:
            print("You’re moving the device around too quickly. Slow down.")
          case .insufficientFeatures:
            print("Something is blocking the camera or the lense is dirty")
          case .initializing, .relocalizing:
            print("Please wait a moment...")
          @unknown default:
            print("Only God can help us now...")
          }
        }
    }
    
    // Gets called everytime a plane is detected an an ARAnchor added to the scene
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard
            let planeAnchor = anchor as? ARPlaneAnchor
        else {
            return
        }
          
        print("Found a plane")
        // we have a horizontal plane, aka piece of floor is detected where we can place furniture
        // Now we'll draw the grid on the floor for each detected plane
        drawPlane(on: node, for: planeAnchor)
    }
    
    private func drawPlane(on node: SCNNode, for anchor: ARPlaneAnchor) {
        
        if anchor.alignment == .horizontal {
            let planeNode = SCNNode(geometry: SCNPlane(
                width: CGFloat(anchor.extent.x),
                height: 1)
            )
            
            planeNode.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
            planeNode.geometry?.firstMaterial?.isDoubleSided = true
            planeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "grid")
            planeNode.eulerAngles = SCNVector3(-Double.pi / 2, 0, 0)
            planeNode.name = "horizontal"
            node.addChildNode(planeNode)
        }
    }
    
    // ARKit delegate method that gets called each time when the information for an existing node anchor get updated
    // i.a camera is position better, ARKit has a better context of the entire room etc
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        guard
            let planeAnchor = anchor as? ARPlaneAnchor
        else {
            return
        }

        // Remove existing grid and draw an updated grid
        node.enumerateChildNodes({ (childNode, _) in
            childNode.removeFromParentNode()
        })

        drawPlane(on: node, for: planeAnchor)
    }
    
    // ARKit delegate method that gets called each time the node anchor disapears from the scene
    // i.e when user goes to another corrner of the room and we can't see that anchor anymore
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {

        guard
            anchor is ARPlaneAnchor
        else {
            return
        }

        // Remove existing grid and draw an updated grid
        node.enumerateChildNodes({ (childNode, _) in
            childNode.removeFromParentNode()
        })
    }
    
    func addFurniture(at hitResult: ARRaycastResult) {
        let transform = hitResult.worldTransform
        let positionColum = transform.columns.3
        let initialPosition = SCNVector3(positionColum.x, positionColum.y, positionColum.z)
        
        guard let currentFurniture = furnitureService.getActiveFurnitureFromLocalStorage() else {
            return
        }
        
        let scene = SCNScene(named: "Models.scnassets/\(currentFurniture.modelReference)/\(currentFurniture.modelReference).scn")!
        let node = (scene.rootNode.childNode(withName: currentFurniture.modelReference, recursively: false))!

        let plateMaterial = SCNMaterial()
        plateMaterial.lightingModel = .physicallyBased
        plateMaterial.normal.contents = UIImage(named: "Models.scnassets/\(currentFurniture.modelReference)/textures/\(currentFurniture.texture)")
        plateMaterial.normal.intensity = 0.5
        plateMaterial.diffuse.contents = UIImage(named: "Models.scnassets/\(currentFurniture.modelReference)/textures/\(currentFurniture.difuseTexture)")
        plateMaterial.metalness.contents = 0.8
        plateMaterial.roughness.contents = 0.2
        node.geometry?.firstMaterial = plateMaterial
        node.position = initialPosition
        sceneView.scene.rootNode.addChildNode(node)
    }
}
