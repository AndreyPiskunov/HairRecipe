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
                    Text("Procedure:")
                        .foregroundColor(Color(.darkGray))
                }
                LabeledContent {
                    Text(client.date, style: .date)
                } label: {
                    Text("Date:")
                        .foregroundColor(Color(.darkGray))
                }
                LabeledContent {
                    Text(client.price)
                    Text("RUB")
                } label: {
                    Text("Price:")
                        .foregroundColor(Color(.darkGray))
                }
            }
            Section("Recipe:") {
                Text(client.recipe)
                    .foregroundColor(.gray)
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
