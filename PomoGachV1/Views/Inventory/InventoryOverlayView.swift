//
//  InventoryOverlayView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/4/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct InventoryOverlayView: View {
    @Binding var showOverlay: Bool
    @EnvironmentObject var gameState: GameState
    // When an item is tapped, call onSelect to notify the parent view.
    var onSelect: (GachaItem) -> Void

    // 3-column grid layout
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            HStack {
                Text("Inventory")
                    .font(.headline)
                Spacer()
                Button("Close") {
                    showOverlay = false
                }
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(gameState.groupedInventory, id: \.item.id) { entry in
                        ZStack(alignment: .bottomTrailing) {
                            VStack {
                                Image(entry.item.spriteName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                Text(entry.item.name)
                                    .font(.headline)
                                    .padding(.top, 5)
                            }
                            // Duplicate counter in bottom-right
                            Text("x\(entry.count)")
                                .font(.caption)
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .offset(x: -5, y: -5)
                        }
                        .onTapGesture {
                            // When tapped, send the item back and dismiss the overlay.
                            onSelect(entry.item)
                            showOverlay = false
                        }
                    }
                }
                .padding()
            }
        }
        .frame(width: 250, height: 350)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

struct InventoryOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryOverlayView(showOverlay: .constant(true), onSelect: { _ in })
            .environmentObject(GameState())
    }
}
