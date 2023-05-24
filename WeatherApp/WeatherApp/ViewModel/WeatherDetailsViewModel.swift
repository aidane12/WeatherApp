//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-30.
//

import Foundation
import SwiftUI

class WeatherDetailsViewModel: ObservableObject {
    
    private var cityName : String
    @Published var weather = Weather(temp: 0, city: City(name: "no name", country: "no country", time: "no time"), imageURL: "no image", tempFerinheight: 0 , image: Image("placeholder"))
    @Published var isLoading = true
        
    let networkManager: NetworkManagerProtocol
    
    init(cityName: String, networkManager: NetworkManagerProtocol = NetworkManager()) {
            self.networkManager = networkManager
            self.cityName = cityName
            self.getWeatherData(cityName: cityName) { [self] weather in
        
                isLoading = false
                
                self.weather.tempCelcuis = weather.current.temperature
                self.weather.city.country = weather.location.country
                self.weather.city.time = weather.location.localtime
                self.weather.imageURL = weather.current.weather_icons[0]
                self.weather.city.formattedDate = self.weather.city.time.convertToDisplayDateFormat()
                self.weather.city.formattedTime = self.weather.city.time.convertToDisplayTimeFormat()
                
                
                self.getWeatherImage(withString: self.weather.imageURL) { image, error in
                    self.weather.image = image
                    self.weather.setSharableDetails()
                    
                }
            }
            self.weather.city.name = cityName
        
    }

    func getWeatherData(cityName: String, completion: @escaping (WeatherResponse) -> ()) {
        
        networkManager.getWeather(cityName: cityName) { (weatherResponse, error) in
            guard let weather = weatherResponse else { return }
            DispatchQueue.main.async {
                completion(weather)
            }
        }
        weather.tempFerinheight = calculateFahrenheit(celsius: weather.tempCelcuis)
    }
    
    func getWeatherImage(withString: String, completion: @escaping (Image, NetworkError?) -> ()) {
        networkManager.getImageWith(imageString: withString) { image, error in
            DispatchQueue.main.async {
                completion(image, error)
            }
        }
    }
    
    func calculateFahrenheit(celsius: Int) -> Int {
        var fahrenheit: Int
        fahrenheit = celsius * 9 / 5 + 32
        return fahrenheit
    }
}


