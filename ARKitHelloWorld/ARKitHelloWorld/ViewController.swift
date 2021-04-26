//
//  ViewController.swift
//  ARKitHelloWorld
//
//  Created by nermin on 22/04/2021.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Show more data on the screen
        sceneView.debugOptions = [
            .showWorldOrigin,
            .showFeaturePoints
        ]
        
        sceneView.autoenablesDefaultLighting = true
        drawShpereAtOrigin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // MARK: Custom functions
    
    func drawShpereAtOrigin() {
        // Create a blank shphere
        let sphere = SCNNode(geometry: SCNSphere(radius: 0.05))
        
        // Add color to the sphhere to difuse object
        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        
        // If you want color to be affected by the light add specular
        sphere.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        // Add the shape to the origin
        sphere.position = SCNVector3(0, 0, 0)
        
        // Add the shape as the child of the rootNode
        sceneView.scene.rootNode.addChildNode(sphere)
    }
}
