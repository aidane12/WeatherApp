//
//  ContentView.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-29.
//
//testing

import SwiftUI
import CoreData

struct SearchView: View {
    
    @ObservedObject var viewModel = SearchViewModel()
    @State var cityName: String = ""
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.searchResults, id: \.self) { city in
                    NavigationLink {
                        WeatherDetailsView(viewModel: WeatherDetailsViewModel(cityName: city))
                    } label: {
                        Text(city)
                    }
                }
            }
            .navigationTitle("Weather Search")
            .navigationBarTitleDisplayMode(.inline)
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
