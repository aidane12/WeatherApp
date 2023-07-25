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
    // Camel case vars in Swift instead of using underscore
    let localTime: String
    let localTimeEpoch: Int
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: localTime) ?? Date()
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, country
        
        // This is how we relate the property name from the API response to the property in our class if their keys aren't identical.
        case localTime = "localtime"
        case localTimeEpoch = "localtime_epoch"
    }
}

struct CurrentWeather : Decodable {
    let temperature: Int
    let observationTime: String
    let weatherIcons: [String]
    
    private enum CodingKeys: String, CodingKey {
        case temperature
        
        // Same concept as above
        case observationTime = "observation_time"
        case weatherIcons = "weather_icons"
    }
}
