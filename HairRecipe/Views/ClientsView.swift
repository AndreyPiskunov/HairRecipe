//
//  ContentView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 01.03.2023.
//

import SwiftUI

struct ClientsView: View {
    
    @State private var isShowNewClient = false
    
    @FetchRequest(fetchRequest: Client.allClients()) private var clients
    
    var provider = ClientsProvider.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(clients) { client in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination:  ClientDetailView(client: client)) {
                            EmptyView()
                        }
                        ClientRowView(client: client)
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
        
        let preview = ClientsProvider.shared
        
        ClientsView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
            .previewDisplayName("Clients with Data")
            .onAppear{
                Client.makePreview(count: 10, in: preview.viewContext)
            }
    }
}
