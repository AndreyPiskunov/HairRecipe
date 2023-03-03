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
        persistentContainer.loadPersistentStores { __, error in
            if let error {
                fatalError("Unable to store with: \(error)")
            }
        }
    }
}

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

