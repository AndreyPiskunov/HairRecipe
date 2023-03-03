//
//  HairRecipeApp.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 01.03.2023.
//

import SwiftUI

@main
struct HairRecipeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, ClientsProvider.shared.viewContext)
        }
    }
}
