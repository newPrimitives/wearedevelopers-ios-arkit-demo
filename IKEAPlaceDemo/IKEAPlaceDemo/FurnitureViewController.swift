//
//  FurnitureViewController.swift
//  IKEAPlaceDemo
//
//  Created by nermin on 24/04/2021.
//

import UIKit

class FurnitureViewController: UIViewController {
    
    // MARK: Outlet connections
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private var furniture: [Furniture] = []
    private let service = FurnitureService()
    
    // MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FurnitureTableViewCell", bundle: nil), forCellReuseIdentifier: "FurnitureTableViewCell")
        
        // Fetch all furniture from our furnitureService and save it to a local instance of furniture model array
        furniture = service.getAllFurniture()
    }
}

extension FurnitureViewController: UITableViewDelegate {
    
    // MARK: TableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Capture the didSelectRowAt indexPath and retreave the ID of a clicked furniture
        let selectedFurniture = furniture[indexPath.row]
        
        // Save the selected furniture to local storage so we can retrieve it in SceneKit
        service.saveActiveFurnitureToLocalStorage(with: selectedFurniture.id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension FurnitureViewController: UITableViewDataSource {
    
    // MARK: TableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return furniture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FurnitureTableViewCell", for: indexPath) as! FurnitureTableViewCell
        cell.setup(with: furniture[indexPath.row])
        return cell
    }
}
