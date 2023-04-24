//
//  DataController.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-14.
//

import CoreData
import Foundation

class DataContoller: ObservableObject {
    let container = NSPersistentContainer(name: "savedSearches")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
    }
}

