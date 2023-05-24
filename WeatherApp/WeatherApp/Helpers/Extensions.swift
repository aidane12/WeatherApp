//
//  Extensions.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-11.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayDateFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertToDayMonthYearFormat()
    }
    
    func convertToDisplayTimeFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertToTimeFormat()
    }
}

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
