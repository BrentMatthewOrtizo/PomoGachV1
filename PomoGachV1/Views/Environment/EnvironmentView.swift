//
//  EnvironmentView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/4/25.
//

import SwiftUI

// Model representing an item placed in the environment
struct PlacedItem: Identifiable {
    let id = UUID()
    let item: GachaItem
    var position: CGPoint
}

struct EnvironmentView: View {
    @EnvironmentObject var gameState: GameState
    @State private var placedItems: [PlacedItem] = []
    
    // Toggle for showing the inventory overlay
    @State private var showInventoryOverlay: Bool = false

    var body: some View {
        ZStack {
            // Background canvas that accepts drops
            Color(.systemGray6)
                .ignoresSafeArea()
                .onDrop(of: ["public.text"], isTargeted: nil, perform: handleDrop(providers:location:))
            
            // Display each placed item; each can be repositioned with drag gestures
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
            
            // Inventory overlay toggle button
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
            
            // Inventory overlay popup for drag source
            if showInventoryOverlay {
                InventoryOverlayView(showOverlay: $showInventoryOverlay)
                    .environmentObject(gameState)
                    .frame(width: 300, height: 400)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
        }
        .navigationTitle("Environment")
        .onAppear {
            // Later: Load persisted placedItems if needed.
        }
    }
    
    // onDrop handler: Loads a dragged string (expected format "name:spriteName") and creates a PlacedItem at the drop location.
    func handleDrop(providers: [NSItemProvider], location: CGPoint) -> Bool {
        for provider in providers {
            if provider.canLoadObject(ofClass: NSString.self) {
                provider.loadObject(ofClass: NSString.self) { (object, error) in
                    if let str = object as? String {
                        let components = str.split(separator: ":")
                        if components.count == 2 {
                            let name = String(components[0])
                            let spriteName = String(components[1])
                            let newItem = GachaItem(name: name, spriteName: spriteName)
                            let newPlacedItem = PlacedItem(item: newItem, position: location)
                            DispatchQueue.main.async {
                                placedItems.append(newPlacedItem)
                                // Later: Persist placedItems here.
                            }
                        }
                    }
                }
                return true
            }
        }
        return false
    }
}

struct EnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentView()
            .environmentObject(GameState())
    }
}
