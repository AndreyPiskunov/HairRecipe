//
//  ContentView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 01.03.2023.
//

import SwiftUI

struct ClientsView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach((0...10), id: \.self) { item in
                }
            }
            .navigationTitle("Clients")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ClientsView()
    }
}
