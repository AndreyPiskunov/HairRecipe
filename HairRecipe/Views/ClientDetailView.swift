//
//  ClientDetailView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import SwiftUI

struct ClientDetailView: View {
    var body: some View {
        List {
            Section("Biography") {
                LabeledContent {
                    Text("Procedure")
                } label: {
                    Text("Procedure")
                }
                LabeledContent {
                    Text(.now, style: .date)
                } label: {
                    Text("Date")
                }
                LabeledContent {
                    Text("Price")
                } label: {
                    Text("Price")
                }
            }
            Section("Recipe") {
                LabeledContent {
                    Text("Recipe")
                } label: {
                    Text("Recipe")
                }
            }
        }
        .navigationTitle("NameHERE")
    }
}

struct ClientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ClientDetailView()
        }
    }
}
