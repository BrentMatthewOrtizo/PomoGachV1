//
//  InventoryOverlayView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/4/25.
//

import SwiftUI

struct InventoryOverlayView: View {
    @Binding var showOverlay: Bool
    @EnvironmentObject var gameState: GameState
    
    // Define a 3-column grid layout
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
                            // Display duplicate count
                            Text("x\(entry.count)")
                                .font(.caption)
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .offset(x: -5, y: -5)
                        }
                        .onDrag {
                            // Encode as "name:spriteName"
                            let dragString = "\(entry.item.name):\(entry.item.spriteName)"
                            return NSItemProvider(object: dragString as NSString)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct InventoryOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryOverlayView(showOverlay: .constant(true))
            .environmentObject(GameState())
    }
}
