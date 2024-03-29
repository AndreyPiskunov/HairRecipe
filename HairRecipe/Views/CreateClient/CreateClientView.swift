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
    @State private var showErrorAlert: Bool = false
    @FocusState private var fieldFocus: FocusOnFields?
    
    let successfulAction: () -> Void
    
    var body: some View {
        List {
            Section("Biography") {
                TextField ("Name", text: $viewModel.client.name)
                    .submitLabel(.next)
                    .focused($fieldFocus, equals: .nameField)
                
                TextField ("Procedure", text: $viewModel.client.procedure)
                    .submitLabel(.next)
                    .focused($fieldFocus, equals: .procedureField)
                
                DatePicker("Date", selection: $viewModel.client.date, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                
                TextField ("Price", text: $viewModel.client.price)
                    .keyboardType(.numberPad)
                    .focused($fieldFocus, equals: .priceField)
            }
            Section("Recipe") {
                TextField ("Enter recipe or note",
                           text: $viewModel.client.recipe,
                           axis: .vertical)
                .focused($fieldFocus, equals: .recipeField)
                .frame(minHeight: 40)
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    fieldFocus = .nameField
                }
            }
        }
        .onSubmit {
            switch fieldFocus {
            case .nameField:
                fieldFocus = .procedureField
            case .procedureField:
                fieldFocus = .priceField
            default:
                fieldFocus = nil
            }
        }
        .navigationTitle(viewModel.isNewClient ? "New Client" : "Edit Client")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    validateCorrectClient()
                } label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title2)
                        .foregroundColor(ColorsApp.customGreen)
                }
            }
            ToolbarItem(placement: .principal) {
                Capsule()
                    .fill(.gray)
                    .frame(width: 40, height: 4)
            }
        }
        .alert("Client is not saved", isPresented: $showErrorAlert, actions:{}) {
            Text("Please, enter the information.")
        }
    }
}

private extension CreateClientView {
    
    func validateCorrectClient() {
        if viewModel.client.isValid {
            do {
                try viewModel.saveClientContext()
                dismiss()
                successfulAction()
            } catch {
                print(error)
            }
        } else {
            showErrorAlert = true
            HapticManager.instance.notification(type: .error)
        }
    }
}

//struct CreateClientView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            let preview = ClientsProvider.shared
//
//            CreateClientView(viewModel: .init(provider: preview))
//                .environment(\.managedObjectContext, preview.viewContext)
//        }
//    }
//}
