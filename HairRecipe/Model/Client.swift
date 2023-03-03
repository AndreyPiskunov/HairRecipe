//
//  Client.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 02.03.2023.
//

import Foundation
import CoreData

final class Client: NSManagedObject, Identifiable {
    //MARK: - Properties
    
    @NSManaged var date: Date
    @NSManaged var name: String
    @NSManaged var price: String
    @NSManaged var procedure: String
    @NSManaged var recipe: String
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(Date.now, forKey: "date")
    }
}
//MARK: - Extensions

extension Client {
    
    private static var clientsFetchRequest: NSFetchRequest<Client> {
        NSFetchRequest(entityName: "Client")
    }
    
    static func all() -> NSFetchRequest<Client> {
        let request: NSFetchRequest<Client> = clientsFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Client.name, ascending: true)
        ]
        return request
    }
}
