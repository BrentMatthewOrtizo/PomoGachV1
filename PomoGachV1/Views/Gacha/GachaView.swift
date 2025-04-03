//
//  GachaView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/3/25.
//

import SwiftUI

struct GachaView: View {
    // An array of test items using your sprite names
    let testItems = [
        GachaItem(name: "Fan", spriteName: "spriteFan"),
        GachaItem(name: "Journal", spriteName: "spriteJournal"),
        GachaItem(name: "Pot", spriteName: "spritePot")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Gacha Test")
                .font(.largeTitle)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    ForEach(testItems) { item in
                        VStack {
                            Image(item.spriteName)  // Must match asset catalog name exactly
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
        }
        .navigationTitle("Gacha")
    }
}

struct GachaView_Previews: PreviewProvider {
    static var previews: some View {
        GachaView()
    }
}
