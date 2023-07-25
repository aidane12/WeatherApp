//
//  SearchViewModel_Tests.swift
//  WeatherAppTests
//
//  Created by Aidan Egan on 2023-05-11.
//

import Foundation
import XCTest
import CoreData
@testable import WeatherApp
import SwiftUI


final class SearchViewModel_Tests: XCTestCase {
    let viewModel = SearchViewModel(networkManager: MockNetworkManager())
    
    func testSearchView_getSearchResultsFromAPI_success() {
        let searchTerm = "london"
        
        viewModel.getSearchResultsFromAPI(searchTerm: searchTerm) { searchResultResponse, error in
            XCTAssertEqual(searchResultResponse?.results[0].name, "London")
            XCTAssertEqual(searchResultResponse?.results[2].name, "Londonderry")
        }
    }
    
    func testSearchView_getSearchResultsFromAPI_failure_emptySearch() {
        let searchTerm = ""
        
        viewModel.getSearchResultsFromAPI(searchTerm: searchTerm) { searchResultResponse, error in
            XCTAssertEqual(error?.rawValue, "user data error")
        }
    }

    func testSearchView_addSearchResultsToView_success() {
        viewModel.searchTerm = "london"
        
        // Removed redundant test you already handle above.
        
        viewModel.addSearchResultsToView() { success in
            if success {
                
                // Use AssertEqual instead of AssertTue with ==
                XCTAssertEqual(self.viewModel.searchResultsViewArray[0], "London")
            } else {
                XCTFail("Search results view contains no results")
            }
        }
    }
}
