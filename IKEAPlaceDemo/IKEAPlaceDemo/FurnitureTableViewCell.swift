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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
