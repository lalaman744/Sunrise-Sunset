//
//  SunTimes.swift
//  Sunrise Sunset
//
//  Created by Josh Kleinschmidt on 4/8/19.
//  Copyright © 2019 Josh Kleinschmidt. All rights reserved.
//

import Foundation

struct Results: Decodable {
    
    let results: SunTimes
    
}

struct SunTimes: Decodable {
    
    let sunrise: String
    let sunset: String
    
}

extension SunTimes {
    
    static let utcDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm:ss a" //same format as in the API response
        df.timeZone = TimeZone(abbreviation: "UTC")
        return df
    }()
    
    static let localDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.calendar = NSCalendar.current
        df.timeZone = TimeZone.current  //Devices timezone
        df.timeStyle = .medium
        return df
    }()
    
    init(from decoder: Decoder) {
        
        // turn strings to local dates
        let container = try! decoder.container(keyedBy: CodingKey.self)
        let sunriseUTCString = try! container.decode(String.self, forKey: CodingKey.sunrise)
        let sunsetUTCString = try! container.decode(String.self, forKey: CodingKey.sunset)
        
        //convert to timestamp, in UTC
        let sunriseUTCDate = SunTimes.utcDateFormatter.date(from: sunriseUTCString)
        let sunsetUTCDate = SunTimes.utcDateFormatter.date(from: sunsetUTCString)
        
        //convert UTC timestamp to local time for device
        sunrise = SunTimes.localDateFormatter.string(from: sunriseUTCDate!)
        sunset = SunTimes.localDateFormatter.string(from: sunsetUTCDate!)
    }
}
