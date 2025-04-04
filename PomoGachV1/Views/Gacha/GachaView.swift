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

    // MARK: - Animation States
    @State private var showAnimation = false
    @State private var boxOffset: CGFloat = 1000      // Box starts off-screen
    @State private var leftFlapAngle: Double = 0      // Left flap rotation
    @State private var rightFlapAngle: Double = 0     // Right flap rotation
    @State private var showItemPopup = false
    @State private var rolledItem: GachaItem?

    // Inventory sheet toggle
    @State private var showInventory = false

    var body: some View {
        ZStack {
            // Main Gacha UI
            VStack(spacing: 20) {
                Text("Points: \(gameState.points)")
                    .font(.title2)

                Button("Roll (Cost: 1 Point)") {
                    startRollAnimation()
                }
                .padding()
                .background(gameState.points > 0 ? Color.orange : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(gameState.points <= 0)

                Button("Inventory") {
                    showInventory = true
                }
                .font(.headline)
                .padding()
                .background(Color.blue.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .navigationTitle("Gacha")
            .sheet(isPresented: $showInventory) {
                InventoryView()
                    .environmentObject(gameState)
            }

            // MARK: - Box Animation Overlay
            if showAnimation {
                // Dimmed background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        closeRollAnimation()
                    }

                // The box (with two top flaps)
                VStack(spacing: 0) {
                    // -- TOP FLAPS (split into two rectangles) --
                    HStack(spacing: 0) {
                        // Left flap (anchor at topTrailing so it rotates outward)
                        Rectangle()
                            .fill(Color.brown)
                            .frame(width: 75, height: 20)
                            .rotationEffect(.degrees(rightFlapAngle), anchor: .topTrailing)

                        // Right flap (anchor at topLeading so it rotates outward)
                        Rectangle()
                            .fill(Color.brown)
                            .frame(width: 75, height: 20)
                            .rotationEffect(.degrees(leftFlapAngle), anchor: .topLeading)
                    }

                    // -- BOX BODY --
                    Rectangle()
                        .fill(Color.brown)
                        .frame(width: 150, height: 100)

                    // -- BOTTOM FLAP (optional) --
                    Rectangle()
                        .fill(Color.brown)
                        .frame(width: 150, height: 20)
                }
                .cornerRadius(4)
                .offset(y: boxOffset)
                .onTapGesture {
                    closeRollAnimation()
                }

                // MARK: - Item Popup
                if showItemPopup, let rolledItem = rolledItem {
                    VStack(spacing: 10) {
                        Text("You have received:")
                            .font(.headline)
                        Text(rolledItem.name)
                            .font(.title)
                        Image(rolledItem.spriteName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                }
            }
        }
    }

    // MARK: - Animation Logic

    private func startRollAnimation() {
        guard gameState.points > 0 else { return }

        // Roll logic
        if let newItem = possibleItems.randomElement() {
            gameState.rollForItem(newItem)
            rolledItem = newItem
        }

        // Begin the box animation
        showAnimation = true
        withAnimation(.easeOut(duration: 0.5)) {
            boxOffset = 0  // Slide the box to the center
        }

        // Open the flaps after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeIn(duration: 0.4)) {
                // Rotate left flap to -90°, right flap to +90° for outward opening
                leftFlapAngle = -90
                rightFlapAngle = 90
            }
            // Show the item popup after the flaps open
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showItemPopup = true
            }
        }
    }

    private func closeRollAnimation() {
        // Reverse the animation
        withAnimation(.easeIn(duration: 0.3)) {
            showItemPopup = false
            leftFlapAngle = 0
            rightFlapAngle = 0
            boxOffset = 1000
        }
        // Hide the entire overlay after the animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            showAnimation = false
        }
    }
}

struct GachaView_Previews: PreviewProvider {
    static var previews: some View {
        GachaView()
            .environmentObject(GameState())
    }
}
