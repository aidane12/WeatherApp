//
//  Extensions.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-11.
//

import Foundation

// By using computed props, we can keep this logic out of a String extension

extension Date {
    
    func convertToDayMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: self)
    }
    
    func convertToTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
}
