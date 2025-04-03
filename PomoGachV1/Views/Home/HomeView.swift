//
//  HomeView.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/2/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                NavigationLink(destination: GachaView()) {
                    Text("Go to Gacha")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: EnvironmentView()) {
                    Text("Decorate Environment")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

struct GachaView: View {
    var body: some View {
        VStack {
            Text("Gacha Screen")
                .font(.largeTitle)
                .padding()
            // TODO: Add gacha roll functionality here.
        }
        .navigationTitle("Gacha")
    }
}

struct EnvironmentView: View {
    var body: some View {
        VStack {
            Text("Environment Screen")
                .font(.largeTitle)
                .padding()
            // TODO: Add environment decoration functionality here.
        }
        .navigationTitle("Environment")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
