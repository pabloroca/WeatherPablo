//
//  ForecastNetworkController.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 17/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import Foundation
import Alamofire

/// Forecast network controller
public class ForecastNetworkController {
   
   /**
    Reads Forecast JSON from network
    
    - returns: completionHandler: (success: Bool).
    */
   public func readFromServer(
      completionHandler: (success: Bool) -> Void
      )
   {
      PR2Networking.sharedInstance.request(0, method:Alamofire.Method.GET, urlString: EndPoints.forecast5, parameters: nil, encoding: .URL, headers: nil) { (success, response, statuscode) -> Void in
         if (success) {
            ForecastDataController().addIntoLocalData(response.data, completionHandler: { (success) -> Void in
               completionHandler(success: success)
            })
         } else {
            completionHandler(success: false)
         }
      }
   }
}