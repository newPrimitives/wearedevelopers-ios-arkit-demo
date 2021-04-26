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
                texture: "chair_NORMAL.png",
                difuseTexture: "chair_DIFFUSE.png",
                stock: 5
            ),
            Furniture(
                id: 1,
                image: "candle",
                name: "Candle",
                modelReference: "candle",
                texture: "candle_NORMAL.png",
                difuseTexture: "candle_DIFFUSE.png",
                stock: 5
            ),
            Furniture(
                id: 2,
                image: "cup",
                name: "Cup",
                modelReference: "cup",
                texture: "cup_NORMAL.png",
                difuseTexture: "cup_DIFFUSE.png",
                stock: 5
            ),
            Furniture(
                id: 3,
                image: "lamp",
                name: "Lamp",
                modelReference: "lamp",
                texture: "lamp_NORMAL.png",
                difuseTexture: "lamp_DIFFUSE.png",
                stock: 5
            ),
            Furniture(
                id: 4,
                image: "vase",
                name: "Vase",
                modelReference: "vase",
                texture: "vase_NORMAL.png",
                difuseTexture: "vase_DIFFUSE.png",
                stock: 5
            ),
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
