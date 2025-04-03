//
//  GachaView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/3/25.
//

import SwiftUI

struct GachaView: View {
    @EnvironmentObject var gameState: GameState

    let possibleItems = [
        GachaItem(name: "Fan", spriteName: "spriteFan"),
        GachaItem(name: "Journal", spriteName: "spriteJournal"),
        GachaItem(name: "Pot", spriteName: "spritePot")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Points: \(gameState.points)")
                .font(.title2)
            
            Button("Roll (Cost: 1 Point)") {
                rollForItem()
            }
            .padding()
            .background(gameState.points > 0 ? Color.orange : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(gameState.points <= 0)
            
            Text("Gacha Test")
                .font(.largeTitle)
            
            // Display the current inventory from GameState
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    ForEach(gameState.inventory) { item in
                        VStack {
                            Image(item.spriteName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            Text(item.name)
                                .font(.headline)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Gacha")
    }
    
    private func rollForItem() {
        if let newItem = possibleItems.randomElement() {
            gameState.rollForItem(newItem)
        }
    }
}

struct GachaView_Previews: PreviewProvider {
    static var previews: some View {
        GachaView()
            .environmentObject(GameState())
    }
}
