//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-30.
//

import Foundation
import UIKit
import SwiftUI
import Network

enum NetworkError: String {
    case apiFailed = "api error"
    case userInputError = "user data error"
}

protocol NetworkManagerProtocol {
    func getWeather(cityName: String, completion: @escaping (WeatherResponse?, NetworkError?) -> Void)
    func getImageWith(imageString: String, completion: @escaping (Image, NetworkError?) -> Void)
    func getSearchResults(searchTerm: String, completion: @escaping(SearchResultResponse, NetworkError?)-> Void)
}

class NetworkManager: ObservableObject, NetworkManagerProtocol {
    let monitor = NWPathMonitor()
    @Published var isDisconnected = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .unsatisfied {
                    self.isDisconnected = true
                } else {
                    self.isDisconnected = false
                }
            }
        }
        monitor.start(queue: DispatchQueue(label: "Network Manager"))
    }
    
    func getWeather(cityName: String, completion: @escaping (WeatherResponse?, NetworkError?) -> Void) {
            guard let weatherUrl = URL(string: AppConstants.weatherURLString + cityName) else {
                return
            }
            
            URLSession.shared.dataTask(with: weatherUrl) { data, response, error in
                if error == nil {
                    guard let data = data else {return}
                    do {
                        let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        completion(result, nil)
                    } catch {
                        completion(nil, NetworkError.apiFailed)
                    }
                }
            }.resume()
    }
    
    func getImageWith(imageString: String, completion: @escaping (Image, NetworkError?) -> Void) {
        guard let url = URL(string: imageString) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
       
            do {
                let imageData = try Data(contentsOf: url)
                if let image = UIImage(data: imageData) {
                        completion(Image(uiImage: image), nil)
                } else {
                        completion(Image(uiImage: UIImage(named: "placeholder")!), nil)
                }
            } catch {
                completion(Image(uiImage: UIImage(named: "placeholder")!), NetworkError.apiFailed)
            }
        }
    }
    
    func getSearchResults(searchTerm: String, completion: @escaping(SearchResultResponse, NetworkError?)-> Void) {
        guard let searchUrl = URL(string: AppConstants.searchURLString + searchTerm) else {return}
        
        URLSession.shared.dataTask(with: searchUrl) { data, response, error in
            if error == nil {
                guard let data = data else {return}
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    completion(result, nil)
                } catch {
                    debugPrint(error)
                }
            }
        }.resume()
    }
}


