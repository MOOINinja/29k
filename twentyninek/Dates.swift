//
//  Dates.swift
//  29k
//
//  Created by Patrik Adolfsson on 2017-04-25.
//  Copyright © 2017 Chibi Anward. All rights reserved.
//

import Foundation

/**
 Static util functions for working with dates
 */
public class Dates {
    
    public typealias RFC3339Formatter = (DateFormatter, DateFormatter)
    
    // date formatters are not threadsafe, so create new for each call
    public static func getRFC3339Formatter() -> RFC3339Formatter {
        let f = (DateFormatter(), DateFormatter())
        f.0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        f.0.timeZone = TimeZone(secondsFromGMT: 0)
        f.0.calendar = Calendar(identifier: .iso8601)
        f.0.locale = Locale(identifier: "en_US_POSIX")
        f.1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        f.1.timeZone = TimeZone(secondsFromGMT: 0)
        f.1.calendar = Calendar(identifier: .iso8601)
        f.1.locale = Locale(identifier: "en_US_POSIX")
        return f
    }
    
    public static func parseRFC3339Date(_ date: String?, formatter: RFC3339Formatter? = nil) -> Date? {
        guard let date = date else { return nil }
        var f: RFC3339Formatter
        if let formatter = formatter {
            f = formatter
        } else {
            f = (DateFormatter(), DateFormatter())
            f.0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
            f.0.timeZone = TimeZone(secondsFromGMT: 0)
            f.0.calendar = Calendar(identifier: .iso8601)
            f.0.locale = Locale(identifier: "en_US_POSIX")
            f.1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            f.1.timeZone = TimeZone(secondsFromGMT: 0)
            f.1.calendar = Calendar(identifier: .iso8601)
            f.1.locale = Locale(identifier: "en_US_POSIX")
        }
        
        if let t = f.0.date(from: date) {
            return t
        } else if let t = f.1.date(from: date) {
            return t
        }
        //Slim.warn("Couldn't parse date string: [\(date)]")
        return nil
    }
    
    public static func formatRFC3339Date(_ date: Date, formatter: RFC3339Formatter? = nil) -> String {
        var f: RFC3339Formatter
        if let formatter = formatter {
            f = formatter
        } else {
            f = Dates.getRFC3339Formatter()
        }
        return f.1.string(from: date) // use subsecond formatter when formatting
    }
}
