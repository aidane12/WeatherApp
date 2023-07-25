//
//  Weather.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-31.
//

import Foundation
import UIKit
import SwiftUI


struct Weather: Transferable {
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.sharableDetails)
       }
    
    let tempCelcius: Int
    
    // Create fahrenheit temp as a computed property instead of using a separate function
    var tempFahrenheit: Int {
        var fahrenheit: Int
        fahrenheit = tempCelcius * 9 / 5 + 32
        return fahrenheit
    }
    
    let city: City
    let imageURLString: String
    var imageURL: URL? {
        URL(string: imageURLString)
    }
    
    var image: Image = Image("placeholder")
    
    // No need for a mutating func that we call each time. This value can be a computed property
    var sharableDetails: String {
        """
        Weather in \(city.name) \(city.country):
        Celcius temp: \(tempCelcius)
        Fahrenheit temp: \(tempFahrenheit)
        """
    }
    
    init(tempCelcius: Int, city: City, imageURLString: String) {
        self.tempCelcius = tempCelcius
        self.city = city
        self.imageURLString = imageURLString
    }
    
    // Makes it easier to create this object from the response instead of assigning all the values manually in the VM init method
    static func from(weatherResponse: WeatherResponse) -> Weather {
        return Weather(tempCelcius: weatherResponse.current.temperature, city: City.from(weatherResponse: weatherResponse), imageURLString: weatherResponse.current.weatherIcons.first ?? "")
    }
}

extension Image {
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self.init(uiImage: image)
    }
}
