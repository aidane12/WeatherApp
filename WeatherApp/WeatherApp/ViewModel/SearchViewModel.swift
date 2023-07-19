//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-04.
//

import Foundation
import SwiftUI
import CoreData

final class SearchViewModel: ObservableObject {
    @Published var searchTerm = ""
    var searchResultsViewArray : [String] = []
    @Published var searchResults: [String] = []
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        setupSearchLogic()
    }
    
    func setupSearchLogic() {
        //Using Combine so view can access searchResults:
        $searchTerm
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { searchTerm in //The Publisher assigned to searchTerm
                
                self.addSearchResultsToView() { _ in
                    
                }
                
                return self.searchResultsViewArray.filter { city in //if the cities we have weather data on (api look up call) matches the search term assign it to searchResults
                    city.lowercased().contains(searchTerm.lowercased()) //The operation
                }
            }
            .assign(to: &$searchResults) //The subcriber assigned to searcResult
    }
    
    func getSearchResultsFromAPI(searchTerm: String, completion: @escaping (SearchResultResponse?, NetworkError?) -> ()) {
        if searchTerm == "" {
            completion(nil, NetworkError.userInputError)
        } else {
            
            networkManager.getSearchResults(searchTerm: searchTerm) { searchResultsResponse, error  in
                do {
                    let searchResults = searchResultsResponse
                    completion(searchResults, error)
                }
            }
        }
    }
    
    func addSearchResultsToView(completion: @escaping (Bool) -> ()) {
        self.getSearchResultsFromAPI(searchTerm: searchTerm) { searchResults, error in
            guard let searchResults = searchResults else {
                completion(false)
                return
            }
            for searchResult in searchResults.results {
                let location = searchResult.name 
                if !self.searchResultsViewArray.contains(location) {
                    self.searchResultsViewArray.append(location)
                    completion(true)
                }
            }
            if error != nil {
                completion(false)
            }
        }
    }

    func clearSearchTerm() {
        searchTerm = ""
    }
}
