//
//  ClientsProvider.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import Foundation
import CoreData

final class ClientsProvider {
    //MARK: - Properties
    
    private let persistentContainer: NSPersistentContainer
    static let shared = ClientsProvider()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "ClientsDataModel")
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { __, error in
            if let error {
                fatalError("Unable to store with: \(error)")
            }
        }
    }
}

