//
//  Date+Utils.swift
//  Bankey
//
//  Created by Diego Sierra on 02/12/23.
//

import Foundation


extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    var monthDayYearString: String {
        let dateformatter = Date.bankeyDateFormatter
        dateformatter.dateFormat = "MMM, d, yyyy"
        return dateformatter.string(from: self)
    }
}
