//
//  ContentView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 01.03.2023.
//

import SwiftUI

struct ClientsView: View {
    //MARK: - Properties
    var provider = ClientsProvider.shared
    
    @State private var clientToEdit: Client?
    @State private var clientItem: Client?
    @State private var searchConfig: SearchConfig = .init()
    @State private var showAlert: Bool = false
    @State private var showConformation: Bool = false
    @State private var showSucces: Bool = false
    @State private var showSuccesDelete: Bool = false
    
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
                                        //Delete button
                                        Button(role: .destructive) {
                                            clientItem = client
                                            showConformation.toggle()
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        //Edit button
                                        Button {
                                            clientToEdit = client
                                        } label: {
                                            Label("", systemImage: "scissors")
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
                        HapticManager.instance.impact(style: .soft)
                        clientToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .font(.title2)
                            .foregroundColor(ColorsApp.customGreen)
                    }
                }
            }
            .confirmationDialog("Delete client?",
                                isPresented: $showConformation,
                                titleVisibility: .visible,
                                presenting: clientItem,
                                actions: { client in
                Button(role: .destructive) {
                    withAnimation {
                        do {
                            try provider.deleteClient(client, in: provider.newContext)
                            withAnimation(.spring().delay(0.3)) {
                                showSuccesDelete.toggle()
                            }
                        } catch {
                            //TODO:
                        }
                    }
                } label: {
                    Text("Delete")
                }
            },
                                message: { client in
                Text("\(client.name)")
            })
            .searchable(text: $searchConfig.searchQuery, prompt: "Search a client")
            .sheet(item: $clientToEdit,
                   onDismiss: { clientToEdit = nil },
                   content: { client in
                NavigationStack {
                    CreateClientView(viewModel: .init(provider: provider,
                                                      client: client)) {
                        withAnimation(.spring().delay(0.3)) {
                            showSucces.toggle()
                        }
                    }
                }
            })
            .navigationTitle("Clients")
            .onChange(of: searchConfig) { newValue in
                clients.nsPredicate = Client.filter(newValue.searchQuery)
            }
            .overlay {
                if showSucces {
                    CompleteSaveView()
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                                showSucces.toggle()
                            }
                        }
                } else if showSuccesDelete {
                    CompleteDeleteView()
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                                showSuccesDelete.toggle()
                            }
                        }
                }
            }
        }
    }
}
////MARK: - Preview
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        //Testing preview with clients for not start App
//        let preview = ClientsProvider.shared
//        
//        ClientsView(provider: preview)
//            .environment(\.managedObjectContext, preview.viewContext)
//            .previewDisplayName("Clients with Data")
//            .onAppear{
//                Client.makePreview(count: 10, in: preview.viewContext)
//            }
//        //Testing empty preview for not start App
//        let emptyPreview = ClientsProvider.shared
//        
//        ClientsView(provider: emptyPreview)
//            .environment(\.managedObjectContext, emptyPreview.viewContext)
//            .previewDisplayName("Clients no Data")
//    }
//}
