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

//https://medium.com/tiendeo-tech/ios-how-to-unit-test-core-data-eb4a754f2603
class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "savedSearches")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}

