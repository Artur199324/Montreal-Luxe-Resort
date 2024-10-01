//
//  Montreal_Luxe_ResortApp.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI
import FirebaseCore

@main
struct Montreal_Luxe_ResortApp: App {
    let persistenceController = PersistenceController.shared
    init() {
          FirebaseApp.configure()
      }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
