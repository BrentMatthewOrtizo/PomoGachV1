//
//  GameState.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/3/25.
//

import SwiftUI

class GameState: ObservableObject {
    @Published var points: Int = 1000
    @Published var inventory: [GachaItem] = []
    
    /// Deducts 1 point and adds a given GachaItem to the inventory.
    func rollForItem(_ newItem: GachaItem) {
        guard points >= 1 else { return }
        points -= 1
        inventory.append(newItem)
    }
    
    /// Optionally, a function to add points (for testing or rewards)
    func addPoints(_ amount: Int) {
        points += amount
    }
}

extension GameState {
    /// Computes a grouped view of the inventory,
    /// returning an array of tuples with each unique GachaItem and its count.
    var groupedInventory: [(item: GachaItem, count: Int)] {
        var dict: [String: (GachaItem, Int)] = [:]
        
        for gachaItem in inventory {
            if let (existingItem, count) = dict[gachaItem.spriteName] {
                dict[gachaItem.spriteName] = (existingItem, count + 1)
            } else {
                dict[gachaItem.spriteName] = (gachaItem, 1)
            }
        }
        
        return Array(dict.values)
    }
}
