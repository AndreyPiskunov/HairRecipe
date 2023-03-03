//
//  ClientDetailView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import SwiftUI

struct ClientDetailView: View {
    
    let client: Client
    
    var body: some View {
        List {
            Section("Biography") {
                LabeledContent {
                    Text(client.procedure)
                } label: {
                    Text("Procedure")
                }
                LabeledContent {
                    Text(client.date, style: .date)
                } label: {
                    Text("Date")
                }
                LabeledContent {
                    Text(client.price)
                } label: {
                    Text("Price")
                }
            }
            Section("Recipe") {
                LabeledContent {
                    Text(client.recipe)
                } label: {
                    Text("Recipe")
                }
            }
        }
        .navigationTitle(client.name)
    }
}

struct ClientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ClientDetailView(client: .preview())
        }
    }
}
