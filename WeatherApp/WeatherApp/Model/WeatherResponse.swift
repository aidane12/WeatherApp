//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-30.
//

import Foundation

struct WeatherResponse: Decodable {
    let location : Location
    let current: CurrentWeather
}

struct Location: Decodable {
    let name: String
    let country: String
    let localtime: String
    let localtime_epoch: Int
}

struct CurrentWeather : Decodable {
    let temperature: Int
    let observation_time: String
    let weather_icons: [String]
}
