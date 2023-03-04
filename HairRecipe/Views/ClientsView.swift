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
            ZStack {
                if clients.isEmpty {
                    NoClientsView()
                } else {
                    List {
                        ForEach(clients) { client in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: ClientDetailView(client: client)) {
                                    EmptyView()
                                }
                                ClientRowView(client: client)
                                    .swipeActions(allowsFullSwipe: true) {
                                        
                                        Button(role: .destructive) {
                                            
                                            do {
                                                try delete(client)
                                            } catch {
                                                print(error)
                                            }
                                            
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button {
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        .tint(.orange)
                                    }
                            }
                        }
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

private extension ClientsView {
    
    func delete(_ client: Client) throws {
        
        let context = provider.viewContext
        let existingClient = try context.existingObject(with: client.objectID)
        context.delete(existingClient)
        
        Task(priority: .background) {
            try await context.perform {
                try context.save()
            }
        }
        
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //Testing preview with clients for not start App
        let preview = ClientsProvider.shared
    
        ClientsView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
            .previewDisplayName("Clients with Data")
            .onAppear{
                Client.makePreview(count: 10, in: preview.viewContext)
            }
        //Testing empty preview for not start App
        let emptyPreview = ClientsProvider.shared
        
        ClientsView(provider: emptyPreview)
            .environment(\.managedObjectContext, emptyPreview.viewContext)
            .previewDisplayName("Clients no Data")
    }
}
