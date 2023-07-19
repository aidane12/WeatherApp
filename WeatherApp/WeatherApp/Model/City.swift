//
//  City.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-31.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    var name: String
    var country: String
    var date: Date
    
    // Set these up as computed properties
    var formattedDate: String {
        date.convertToDayMonthYearFormat()
    }
    var formattedTime: String {
        date.convertToTimeFormat()
    }
    
    // Makes it easier to create this object from the response instead of assigning all the values manually in the VM init method
    static func from(weatherResponse: WeatherResponse) -> City {
        return City(name: weatherResponse.location.name, country: weatherResponse.location.country, date: weatherResponse.location.date)
    }
}
