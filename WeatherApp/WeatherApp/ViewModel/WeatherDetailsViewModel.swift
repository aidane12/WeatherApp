//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-30.
//

import Foundation
import SwiftUI

// Add "final" to any class we don't subclass. This helps the compiler make optimizations and is especially useful in larger projects.
final class WeatherDetailsViewModel: ObservableObject {
    
    private var cityName: String
    
    // No need to define an "empty" weather object. Create this as an optional and then once we have the data, populate a Weather object and assign to the variable.
    @Published var weather: Weather?
    @Published var isLoading = true
        
    let networkManager: NetworkManagerProtocol
    
    init(cityName: String, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        self.cityName = cityName
        
        self.getWeatherData(cityName: cityName) { [self] weather in
            isLoading = false
            self.weather = Weather.from(weatherResponse: weather)
            guard var wthr = self.weather else { return }
            
            self.getWeatherImage(withString: wthr.imageURLString) { image, error in
                wthr.image = image
            }
        }
    }

    func getWeatherData(cityName: String, completion: @escaping (WeatherResponse) -> ()) {
        
        networkManager.getWeather(cityName: cityName) { (weatherResponse, error) in
            guard let weather = weatherResponse else { return }
            DispatchQueue.main.async {
                completion(weather)
            }
        }
    }
    
    func getWeatherImage(withString: String, completion: @escaping (Image, NetworkError?) -> ()) {
        networkManager.getImageWith(imageString: withString) { image, error in
            DispatchQueue.main.async {
                completion(image, error)
            }
        }
    }
}


