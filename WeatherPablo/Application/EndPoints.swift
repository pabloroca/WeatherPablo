//
//  EndPoints.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 17/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import Foundation

/// End Points
struct EndPoints {
    
    /// http protocol
    static let httprotocol = "http"
    
    /// base url
    static let mainurl = "\(httprotocol)://api.openweathermap.org/data/2.5/"

   /// city
   static let city = "London"
   
    /// EP for forecast5
    static let forecast5 = "\(mainurl)forecast?q=\(city),uk&units=metric&mode=json&appid=714ee5911157439883582055997cadae"

   /// EP for images
   static let image = "http://openweathermap.org/img/w/"

}
