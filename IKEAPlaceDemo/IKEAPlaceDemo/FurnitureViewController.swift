//
//  FurnitureViewController.swift
//  IKEAPlaceDemo
//
//  Created by nermin on 24/04/2021.
//

import UIKit

class FurnitureViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var furniture: [Furniture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FurnitureTableViewCell", bundle: nil), forCellReuseIdentifier: "FurnitureTableViewCell")
        
        let service = FurnitureService()
        furniture = service.getAllFurniture()
    }
}

extension FurnitureViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension FurnitureViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return furniture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FurnitureTableViewCell", for: indexPath) as! FurnitureTableViewCell
        cell.setup(with: furniture[indexPath.row])
        return cell
    }
}
