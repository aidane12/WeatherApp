//
//  SearchHistoryViewModel_Tests.swift
//  WeatherAppTests
//
//  Created by Aidan Egan on 2023-05-03.
//

import Foundation

import XCTest
import CoreData
@testable import WeatherApp
import SwiftUI

final class SearchHistoryViewModel_Tests: XCTestCase {
    
    var viewModel: SearchHistoryViewModel!
    
    override func setUpWithError() throws {
        viewModel = SearchHistoryViewModel(viewContext: TestCoreDataStack().persistentContainer.newBackgroundContext())
    }
    
    func testSearchHistory_savedSearch() {
        //Given
        let city = City(name: "Dublin", country: "Ireland", time: "10:30")
        viewModel.savedSearch(cityName: city.name)

        //WHEN
        let fetchRequest: NSFetchRequest<CitySearch> = CitySearch.fetchRequest()
        let citySearches = try? viewModel.viewContext.fetch(fetchRequest)
        let cityReturned = citySearches?.first
        
        //THEN
        XCTAssertEqual(citySearches?.count, 1)
        XCTAssertEqual(cityReturned?.name, city.name)
    }
    
    func testSeachHistory_checkIfAlreadyCityExists_true() {
        //Given
        let city = City(name: "Dublin", country: "Ireland", time: "10:30")
        viewModel.savedSearch(cityName: city.name)
        
        //WHEN
        let alreadyExists = viewModel.checkIfAlreadyExists("Dublin")
        
        //THEN
        XCTAssertTrue(alreadyExists)
    }
    
    func testSeachHistory_checkIfAlreadyCityExists_false() {
        //Given
        let city = City(name: "Dublin", country: "Ireland", time: "10:30")
        viewModel.savedSearch(cityName: city.name)
        
        //WHEN
        let alreadyExists = viewModel.checkIfAlreadyExists("Vancouver")
        
        //THEN
        XCTAssertFalse(alreadyExists)
    }
    
    func testSearchHistory_deleteAll() {
        //Given
        let city = City(name: "Dublin", country: "Ireland", time: "10:30")
        let city2 = City(name: "Vancouver", country: "Canada", time: "11:30")
        viewModel.savedSearch(cityName: city.name)
        viewModel.savedSearch(cityName: city2.name)
        
        
        //WHEN
        let fetchRequest: NSFetchRequest<CitySearch> = CitySearch.fetchRequest()
        let citySearches = try? viewModel.viewContext.fetch(fetchRequest)
        XCTAssertEqual(citySearches?.count, 2)
        
        viewModel.deleteAllCities()
        
        let citySearches2 = try? viewModel.viewContext.fetch(fetchRequest)
        
        //THEN
        XCTAssertEqual(citySearches2?.count, 0)
    }    
}
