//
//  SearchHistoryView.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-14.
//

import Foundation
import SwiftUI


struct SearchHistoryView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var citySearches: FetchedResults<CitySearch>

    var body: some View {
        
        let searchHistoryViewModel = SearchHistoryViewModel(viewContext: viewContext)
        
            List {
                ForEach(citySearches, id: \.self) { city in
                    if let city = city.name {
                        NavigationLink(destination: WeatherDetailsView(viewModel: WeatherDetailsViewModel(cityName: city))) {
                            Text(city)
                        }
                    }
                }
                .onDelete { indexSet in
                    searchHistoryViewModel.deleteCitySearch(at: indexSet, citySearches: citySearches)
                    
                }
            }
            .navigationBarTitle("Search History")
            .navigationBarItems(trailing: Button("Delete all", action: {
                print("Delete all ")
            }))
    }
    

    

}


