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
    var time: String
    var formattedDate: String?
    var formattedTime: String?
}
