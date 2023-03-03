//
//  CreateClientView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import SwiftUI

struct CreateClientView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("Biography") {
                TextField ("Name", text: .constant(""))
                    .keyboardType(.namePhonePad)
                TextField ("Procedure", text: .constant(""))
                DatePicker("Date", selection: .constant(.now),
                           displayedComponents: [.date])
                .datePickerStyle(.compact)
                TextField ("Price", text: .constant(""))
                    .keyboardType(.phonePad)
            }
            Section("Recipe") {
                TextField ("Add recipe",
                           text: .constant(""),
                           axis: .vertical)
            }
        }
        .navigationTitle("Add Client")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Done") {
                    dismiss()
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
            CreateClientView()
        }
    }
}
