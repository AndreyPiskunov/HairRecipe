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
    
    private let context: NSManagedObjectContext
    
    init(provider: ClientsProvider, client: Client? = nil) {
        
        self.context = provider.newContext
        self.client = Client(context: self.context)
    }
    
    func saveClientContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
