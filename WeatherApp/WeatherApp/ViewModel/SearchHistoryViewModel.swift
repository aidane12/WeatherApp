//
//  SearchHistoryViewModel.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-14.
//

import Foundation
import SwiftUI
import CoreData

final class SearchHistoryViewModel: ObservableObject {

    let viewContext : NSManagedObjectContext
    var citySearches = [CitySearch]()
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func savedSearch(cityName: String) {
        if !checkIfAlreadyExists(cityName) {
            if !cityName.isEmpty {
                let citySearch = CitySearch(context: viewContext)
                citySearch.id = UUID()
                citySearch.name = cityName
                try? viewContext.save()
            }
        }
    }
    
    func deleteCitySearch(at offsets: IndexSet, citySearches: FetchedResults<CitySearch>) {
        offsets.forEach { index in
            let cityToDelete = citySearches[index]
            viewContext.delete(cityToDelete)
        }
        do {
            try viewContext.save()
        } catch {
            print("error when saving")
        }
    }
    
    func deleteAllCities() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CitySearch")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func checkIfAlreadyExists(_ city: String) -> Bool {
        var alreadyExists = false
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CitySearch")
        let predicate = NSPredicate(format: "name == %@", city)
        request.predicate = predicate
        request.fetchLimit = 1

        do{
            let count = try viewContext.count(for: request)
            if(count == 0){
                alreadyExists = false
            }
            else{
                alreadyExists = true // at least one matching object exists
            }
          }
        catch let error as NSError {
             print("Could not fetch \(error)")
          }
        return alreadyExists
    }
}


