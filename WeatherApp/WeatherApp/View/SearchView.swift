//
//  ContentView.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-29.
//
//testing

import SwiftUI

struct SearchView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State var cityName: String? = ""
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        
        let searchHistoryViewModel = SearchHistoryViewModel(viewContext: viewContext)
       
        NavigationStack {
            List {
                ForEach(viewModel.searchResults, id: \.self) { city in
                    NavigationLink(
                        tag: city,
                        selection: $cityName,
                        destination: {
                            WeatherDetailsView(viewModel: WeatherDetailsViewModel(cityName: city))
                        },
                        label: {Text(city)}
                    )
                }
            }
            .navigationTitle("Weather Search")
            .onDisappear {
                guard let cityName = cityName else { return }
                    searchHistoryViewModel.savedSearch(cityName: cityName)
                viewModel.clearSearchTerm()
            }
            .navigationBarItems(trailing:
            NavigationLink {
                SearchHistoryView()
                
            } label: {
                HStack {
                    Image(systemName: "list.triangle")
                    Text("History")
                }
            })
            .searchable(text: $viewModel.searchTerm, placement: .automatic, prompt: "Enter a city")
            .onSubmit(of: .search){
                print("search suggestion was tapped")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}




