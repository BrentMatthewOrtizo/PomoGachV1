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
