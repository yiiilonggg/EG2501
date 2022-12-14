//
//  EG2501_AppApp.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

@main
struct EG2501_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
