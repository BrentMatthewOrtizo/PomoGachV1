//
//  InventoryView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/3/25.
//

import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.presentationMode) var presentationMode
    
    // Define a simple 3-column grid layout
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
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
                            // Display the duplicate count in the bottom-right corner
                            Text("x\(entry.count)")
                                .font(.caption)
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .offset(x: -5, y: -5)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Inventory")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
            .environmentObject(GameState())
    }
}
