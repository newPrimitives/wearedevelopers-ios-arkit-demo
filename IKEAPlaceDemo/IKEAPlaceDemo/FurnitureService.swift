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
    
    func saveActiveFurnitureToLocalStorage(with id: Int) {
        let defaults = UserDefaults.standard
        defaults.set(id, forKey: "activeFurnitureId")
    }
    
    func getActiveFurnitureFromLocalStorage() -> Furniture? {
        let defaults = UserDefaults.standard
        guard
            let activeFurnitureId = defaults.string(forKey: "activeFurnitureId"),
            let id = Int(activeFurnitureId),
            let furniture = getAllFurniture().first(where: {$0.id == id})
        else {
            return nil
        }
        
        return furniture
    }
}
