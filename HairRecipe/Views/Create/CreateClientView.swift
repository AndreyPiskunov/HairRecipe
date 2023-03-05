//
//  CreateClientView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import SwiftUI

struct CreateClientView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EditClientViewModel
    
    var body: some View {
        List {
            Section("Biography") {
                TextField ("Name", text: $viewModel.client.name)
                    .keyboardType(.namePhonePad)

                TextField ("Procedure", text: $viewModel.client.procedure)
                
                DatePicker("Date", selection: $viewModel.client.date,
                           displayedComponents: [.date])
                .datePickerStyle(.compact)
                
                TextField ("Price", text: $viewModel.client.price)
                    .keyboardType(.phonePad)
            }
            Section("Recipe") {
                TextField ("Add recipe",
                           text: $viewModel.client.recipe,
                           axis: .vertical)
            }
        }
        .navigationTitle(viewModel.isNewClient ? "New Client" : "Edit Client")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Done") {
                    do {
                        try viewModel.saveClientContext()
                        dismiss()
                    } catch {
                       print(error)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct CreateClientView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            
            let preview = ClientsProvider.shared
            
            CreateClientView(viewModel: .init(provider: preview))
                .environment(\.managedObjectContext, preview.viewContext)
        }
    }
}
