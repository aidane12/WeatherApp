//
//  SearchResultResponse.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-05.
//

import Foundation

struct SearchResultResponse: Decodable {
    let results: [CitySearchResult]
}

struct CitySearchResult: Decodable {
    let name: String
    let country: String
}


