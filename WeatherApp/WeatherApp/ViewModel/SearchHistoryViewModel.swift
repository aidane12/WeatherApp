//
//  SearchHistoryViewModel.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-14.
//

import Foundation
import SwiftUI
import CoreData

class SearchHistoryViewModel: ObservableObject {

    let viewContext : NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    
    func savedSearch(cityName: String) {
        if !cityName.isEmpty {
            let citySearch = CitySearch(context: viewContext)
            citySearch.id = UUID()
            citySearch.name = cityName
            try? viewContext.save()
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
}

