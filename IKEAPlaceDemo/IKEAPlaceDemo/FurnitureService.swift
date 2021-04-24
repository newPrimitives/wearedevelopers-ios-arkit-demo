//
//  FurnitureService.swift
//  IKEAPlaceDemo
//
//  Created by nermin on 24/04/2021.
//

import Foundation

class FurnitureService {
    
    func getAllFurniture() -> [Furniture] {
        return [
            Furniture(
                id: 0,
                image: "chair",
                name: "Chair",
                modelReference: "chair",
                stock: 5
            ),
            Furniture(
                id: 1,
                image: "coffee_table",
                name: "Coffe Table",
                modelReference: "coffee_table",
                stock: 4
            )
        ]
    }
}
