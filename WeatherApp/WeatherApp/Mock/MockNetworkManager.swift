//
//  MockNetworkManager.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-25.
//

import Foundation
import UIKit
import SwiftUI

class MockNetworkManager: NetworkManagerProtocol {

    func getWeather(cityName: String, completion: @escaping (WeatherResponse?, NetworkError?) -> Void) {
        
        // Read data from mock json
        if let jsonData = readFile(forName: "MockWeatherDetails") {
            do {
                let data = try JSONDecoder().decode(WeatherResponse.self, from: jsonData)
                completion(data, nil)
            } catch {
               print(error)
            }
        }
    }
    
    func getSearchResults(searchTerm: String, completion: @escaping (SearchResultResponse, NetworkError?) -> Void) {

            if let jsonData = readFile(forName: "MockSearchResultResponse") {
                do {
                        let data = try JSONDecoder().decode(SearchResultResponse.self, from: jsonData)
                        completion(data, nil)
                } catch {
                   print(error)
                }
            }
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
    
    private func readFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
}
