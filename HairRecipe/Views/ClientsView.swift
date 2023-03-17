//
//  ContentView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 01.03.2023.
//

import SwiftUI

struct SearchConfig: Equatable {
    var searchQuery: String = ""
}

struct ClientsView: View {
    //MARK: - Properties
    
    var provider = ClientsProvider.shared
    
    @State private var clientToEdit: Client?
    @State private var searchConfig: SearchConfig = .init()
    @State private var showAlert: Bool = false
    
    @FetchRequest(fetchRequest: Client.allClients()) private var clients
    //MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                if clients.isEmpty {
                    ClearClientsView()
                } else {
                    List {
                        ForEach(clients) { client in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: ClientDetailView(client: client)) {
                                    EmptyView()
                                }
                                ClientRowView(client: client)
                                    .swipeActions(allowsFullSwipe: true) {
                                        
                                        Button() {
                                            showAlert.toggle()
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button {
                                            clientToEdit = client
                                        } label: {
                                            Label("", systemImage: "scissors")
                                        }
                                        .tint(.orange)
                                    }
                            }
                            .alert("Delete client: \(client.name)", isPresented: $showAlert) {
                                Button("Delete", role: .destructive) {
                                    do {
                                        try provider.deleteClient(client, in: provider.newContext)
                                    } catch {
                                        print(error)
                                    }
                                }
                            } message: {
                                Text("Are you sure?")
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        HapticManager.instance.impact(style: .soft)
                        clientToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .font(.title2)
                            .foregroundColor(Color(.darkGray))
                    }
                }
            }
            .searchable(text: $searchConfig.searchQuery)
            .sheet(item: $clientToEdit,
                   onDismiss: { clientToEdit = nil },
                   content: { client in
                NavigationStack {
                    CreateClientView(viewModel: .init(provider: provider,
                                                      client: client))
                }
            })
            .navigationTitle("Clients")
            .onChange(of: searchConfig) { newValue in
                clients.nsPredicate = Client.filter(newValue.searchQuery)
            }
        }
    }
}
//MARK: - Preview

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
