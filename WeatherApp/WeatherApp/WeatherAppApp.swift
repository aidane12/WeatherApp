//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-29.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
