//
//  FurnitureTableViewCell.swift
//  IKEAPlaceDemo
//
//  Created by nermin on 24/04/2021.
//

import UIKit

class FurnitureTableViewCell: UITableViewCell {

    @IBOutlet weak var furniturePreview: UIImageView!
    @IBOutlet weak var furnitureTitle: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    func setup(with furniture: Furniture) {
        furniturePreview.image = UIImage(named: furniture.image)!
        furnitureTitle.text = furniture.name
        stockLabel.text = "\(furniture.stock) in stock"
    }
    
}
