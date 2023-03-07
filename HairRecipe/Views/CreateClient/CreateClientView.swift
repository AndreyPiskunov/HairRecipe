//
//  CreateClientView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import SwiftUI

enum FocusOnFields: Hashable {
    case nameField
    case procedureField
    case priceField
    case recipeField
}

struct CreateClientView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EditClientViewModel
    
    @State private var hasError: Bool = false
    
    @FocusState private var fieldFocus: FocusOnFields?
    
    var body: some View {
        List {
            Section("Biography") {
                TextField ("Name", text: $viewModel.client.name)
                    .keyboardType(.namePhonePad)
                    .focused($fieldFocus, equals: .nameField)
                   
                TextField ("Procedure", text: $viewModel.client.procedure)
                    .focused($fieldFocus, equals: .procedureField)
                
                DatePicker("Date", selection: $viewModel.client.date,
                           displayedComponents: [.date])
                .datePickerStyle(.compact)
                
                TextField ("Price", text: $viewModel.client.price)
                    .keyboardType(.phonePad)
                    .focused($fieldFocus, equals: .priceField)
            }
            Section("Recipe") {
                TextField ("Add recipe",
                           text: $viewModel.client.recipe,
                           axis: .vertical)
                .focused($fieldFocus, equals: .recipeField)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                fieldFocus = .nameField
            }
        }
        .navigationTitle(viewModel.isNewClient ? "New Client" : "Edit Client")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    validateCorrectClient()
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    dismiss()
                }
            }
        }
        .alert("Error", isPresented: $hasError, actions:{}) {
            Text("Please, enter the information")
        }
    }
}

private extension CreateClientView {
    
    func validateCorrectClient() {
        if viewModel.client.isValid {
            do {
                try viewModel.saveClientContext()
                dismiss()
            } catch {
                print(error)
            }
        } else {
            hasError = true
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
