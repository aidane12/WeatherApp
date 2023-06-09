//
//  AppConstants.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-30.
//

import Foundation

struct AppConstants {
    static let apiKey = ""
    static let weatherURLString = "http://api.weatherstack.com/current?access_key=\(apiKey)&query="
    static let searchURLString = "https://api.weatherstack.com/autocomplete?access_key=\(apiKey)&query="
}
