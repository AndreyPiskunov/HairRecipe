//
//  EditClientViewModel.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import Foundation
import CoreData

final class EditClientViewModel: ObservableObject {
    
    @Published var client: Client
    let isNewClient: Bool
    private let provider: ClientsProvider
    private let context: NSManagedObjectContext
    
    init(provider: ClientsProvider, client: Client? = nil) {
        self.provider = provider
        self.context = provider.newContext
        
        if let client,
           let existingClientCopy = provider.exisistsInClients(client, in: context) {
            self.client = existingClientCopy
            self.isNewClient = false
        } else {
            self.client = Client(context: self.context)
            self.isNewClient = true
        }
    }
    
    func saveClientContext() throws {
        try provider.saveClient(in: context)
    }
}

