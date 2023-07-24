//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Aidan Egan on 2023-03-29.
//

import XCTest
@testable import WeatherApp
import SwiftUI

final class WeatherDetailsViewModel_Tests: XCTestCase {
    
    let viewModel = WeatherDetailsViewModel(cityName: "london", networkManager: MockNetworkManager())
    let expectation = XCTestExpectation(description: "Image url call")
    
    func testWeatherDetailsAPICall_getWeatherData_correct() {
        viewModel.getWeatherData(cityName: "london") { weatherResponse in
            XCTAssertEqual(weatherResponse.location.name, "London")
            XCTAssertEqual(weatherResponse.location.country, "United Kingdom")
            
            // No need to make mutiple calls to the API in separate tests
            XCTAssertEqual(weatherResponse.current.temperature, 8)
            XCTAssertEqual(weatherResponse.location.date.convertToDayMonthYearFormat(), "Tuesday, Apr 25" )
            XCTAssertEqual(weatherResponse.location.date.convertToTimeFormat(), "6:27 PM" )
        }
    }
    
    func testWeatherDetailsAPICall_getWeatherImage_success() {
        let imageUrlString = "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"
        
        viewModel.getWeatherImage(withString: imageUrlString) { image, error in
            self.expectation.fulfill()
            XCTAssertNotNil(image)
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func testWeatherDetailsAPICall_getWeatherImage_failure() {
        let imageUrlString = "https://thisIsAFakeUrlImage.jpg"
        viewModel.getWeatherImage(withString: imageUrlString) { image, error in
            self.expectation.fulfill()
            XCTAssertEqual(error, NetworkError.apiFailed)
            
        }
        wait(for: [expectation], timeout: 5)
    }
}
