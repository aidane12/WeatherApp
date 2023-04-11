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
    
    var tempCelcuis: Int
    var tempFerinheight: Int
    var city: City
    var imageURL: String
    var image: Image
    var sharableDetails: String = ""
    
    init(temp: Int, city: City, imageURL: String, tempFerinheight: Int, image: Image) {
        self.tempCelcuis = temp
        self.city = city
        self.imageURL = imageURL
        self.tempFerinheight = tempFerinheight
        self.image = image
        
    }
    
    mutating func setSharableDetails() {
        sharableDetails = """
                        Weather in \(city.name) \(city.country):
                        Celcuis temp: \(tempCelcuis)
                        Ferinheight temp: \(tempFerinheight)
                        """
    }
}
