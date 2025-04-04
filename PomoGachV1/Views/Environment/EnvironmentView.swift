//
//  EnvironmentView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/4/25.
//

import SwiftUI

// Model representing an item that has been placed in the environment
struct PlacedItem: Identifiable {
    let id = UUID()
    let item: GachaItem
    var position: CGPoint
}

struct EnvironmentView: View {
    @EnvironmentObject var gameState: GameState
    @State private var placedItems: [PlacedItem] = []

    var body: some View {
        ZStack {
            // Background canvas for decoration
            Color(.systemGray6)
                .ignoresSafeArea()
            
            // Display each placed item; these can be repositioned via drag gestures
            ForEach(placedItems) { placedItem in
                Image(placedItem.item.spriteName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .position(placedItem.position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if let index = placedItems.firstIndex(where: { $0.id == placedItem.id }) {
                                    placedItems[index].position = value.location
                                }
                            }
                    )
            }
            
            // Instruction overlay at the bottom
            VStack {
                Spacer()
                Text("Drag items to decorate your environment")
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.bottom, 30)
            }
        }
        .navigationTitle("Environment")
        .toolbar {
            // Test button to add a new item at the center of the screen
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add Test Item") {
                    addTestItem()
                }
            }
        }
    }
    
    // For testing: adds a random item from the possible sprites at the screen center.
    func addTestItem() {
        let possibleItems = [
            GachaItem(name: "Fan", spriteName: "spriteFan"),
            GachaItem(name: "Journal", spriteName: "spriteJournal"),
            GachaItem(name: "Pot", spriteName: "spritePot")
        ]
        if let randomItem = possibleItems.randomElement() {
            // Add the new item at the center of the screen
            let center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            let newPlacedItem = PlacedItem(item: randomItem, position: center)
            placedItems.append(newPlacedItem)
        }
    }
}

struct EnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentView()
            .environmentObject(GameState())
    }
}
