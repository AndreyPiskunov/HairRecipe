//
//  ContentView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 01.03.2023.
//

import SwiftUI

struct ClientsView: View {
    @State private var isShowNewClient = false
    var provider = ClientsProvider.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach((0...10), id: \.self) { item in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination:  ClientDetailView()) {
                            EmptyView()
                        }
                        ClientRowView()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowNewClient.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $isShowNewClient) {
                NavigationStack {
                    CreateClientView(viewModel: .init(provider: provider))
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
