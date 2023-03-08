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
    
    var isValid: Bool {
        !name.isEmpty && !procedure.isEmpty && !price.isEmpty && !recipe.isEmpty
    }
    
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
    
    static func allClients() -> NSFetchRequest<Client> {
        let request: NSFetchRequest<Client> = clientsFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Client.name, ascending: true)
        ]
        return request
    }
    
    static func filter(_ query: String) -> NSPredicate {
        query.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[cd] %@", query)
    }
}

extension Client {
    
    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Client] {
        var clients = [Client]()
        for i in 0..<count {
            let client = Client(context: context)
            client.name = "item \(i)"
            client.date = Calendar.current.date(byAdding: .day,
                                                value: -i,
                                                to: .now) ?? .now
            client.procedure = "test\(i)"
            client.price = "222222\(i)"
            client.recipe = "This is preview for item \(i)"
            clients.append(client)
        }
        return clients
    }
    
    static func preview(context: NSManagedObjectContext = ClientsProvider.shared.viewContext) -> Client {
        return makePreview(count: 1, in: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = ClientsProvider.shared.viewContext) -> Client {
        return Client(context: context)
    }
}
