//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-04.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchTerm = ""
    var data : [String] = []

    @Published var searchResults: [String] = [] //when you find matching data we assign to search results
    let networkService = NetworkManager()
    
    init() {
        setupSearchLogic()
    }
    
    func setupSearchLogic() {
        //Using Combine so view can access searchResults:
        $searchTerm
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { searchTerm in //The Publisher assigned to searchTerm
                
                self.addSearchResultsToView()
                
                return self.data.filter { city in //if the cities we have weather data on (api look up call) matches the search term assign it to searchResults
                    city.lowercased().contains(searchTerm.lowercased()) //The operation
                }
            }
            .assign(to: &$searchResults) //The subcriber assigned to searcResult
    }
    
    func getSearchResultsFromAPI(searchTerm: String, completion: @escaping (SearchResultResponse, NetworkError?) -> ()) {
        networkService.getSearchResults(searchTerm: searchTerm) { searchResultsResponse, error  in
            let searchResults = searchResultsResponse
            completion(searchResults, error)
        }
    }
    
    func addSearchResultsToView() {
        self.getSearchResultsFromAPI(searchTerm: searchTerm) { searchResults, error in
            for searchResult in searchResults.results {
                let location = searchResult.name //+ ", " + searchResult.country
                if !self.data.contains(location) {
                    self.data.append(location)
                }
                
            }
        }
    }
    
}
