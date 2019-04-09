//
//  SunTimeDelegate.swift
//  Sunrise Sunset
//
//  Created by Josh Kleinschmidt on 4/9/19.
//  Copyright © 2019 Josh Kleinschmidt. All rights reserved.
//

import Foundation

protocol SunTimeDelegate {
    func timesFetched(suntimes: SunTimes)
    func suntimesError(because suntimesError: SunTimesError)
    
}
