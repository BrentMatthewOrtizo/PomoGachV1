//
//  PomoGachV1App.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/2/25.
//

import SwiftUI

@main
struct PomoGachV1App: App {
    @StateObject private var gameState = GameState()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(gameState) // Now all views can access GameState
        }
    }
}
