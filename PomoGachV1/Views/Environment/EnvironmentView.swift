//
//  EnvironmentView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/4/25.
//

import SwiftUI

// Model representing an item placed in the environment.
struct PlacedItem: Identifiable {
    let id = UUID()
    let item: GachaItem
    var position: CGPoint
}

struct EnvironmentView: View {
    @EnvironmentObject var gameState: GameState
    @State private var placedItems: [PlacedItem] = []
    
    // Controls whether the inventory overlay is shown.
    @State private var showInventoryOverlay: Bool = false
    // Holds the currently selected inventory item (if any).
    @State private var selectedInventoryItem: GachaItem? = nil

    var body: some View {
        ZStack {
            // The background canvas.
            Color(.systemGray6)
                .ignoresSafeArea()
                // Overlay a clear layer that captures tap gestures for placement.
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onEnded { value in
                                        if let selected = selectedInventoryItem {
                                            // Place the selected item at the tapped location.
                                            let location = value.location
                                            placedItems.append(PlacedItem(item: selected, position: location))
                                            selectedInventoryItem = nil
                                        }
                                    }
                            )
                    }
                )
            
            // Show each placed item; each is draggable.
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
            
            // Inventory toggle button.
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showInventoryOverlay.toggle()
                    }) {
                        Text("Inventory")
                            .font(.headline)
                            .padding()
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            
            // Inventory overlay popup.
            if showInventoryOverlay {
                InventoryOverlayView(showOverlay: $showInventoryOverlay, onSelect: { selectedItem in
                    // When an item is selected from the inventory, store it.
                    selectedInventoryItem = selectedItem
                })
                .environmentObject(gameState)
                .frame(width: 250, height: 350)
                .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle("Environment")
    }
}

struct EnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentView()
            .environmentObject(GameState())
    }
}
