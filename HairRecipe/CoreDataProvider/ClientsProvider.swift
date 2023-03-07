//
//  ClientsProvider.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import Foundation
import CoreData
import SwiftUI

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
        if EnvironmentValues.isPreview {
            persistentContainer.persistentStoreDescriptions.first?.url = .init(fileURLWithPath: "/dev/null")
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _ , error in
            if let error {
                fatalError("Unable to store with: \(error)")
            }
        }
    }
    //Verification client to existense in Core Data
    func exisistsInClients(_ client: Client, in context: NSManagedObjectContext) -> Client? {
        try? context.existingObject(with: client.objectID) as? Client
    }
    //Delete client from Core Data
    func deleteClient(_ client: Client, in context: NSManagedObjectContext) throws {
        if let existingClient = exisistsInClients(client, in: context) {
            context.delete(existingClient)
            
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }
    //Save client to Core Data
    func saveClient(in context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
}

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

