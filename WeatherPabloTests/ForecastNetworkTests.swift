//
//  ForecastNetworkTests.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 18/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import WeatherPablo

class ForecastNetworkTests: XCTestCase {

    override func setUp() {
        super.setUp()
      
      // clear database
      ForecastDataController().deleteInLocalData()
      
    }
    
   override func tearDown() {
      super.tearDown()
      
      OHHTTPStubs.removeAllStubs()
      
      // clear database
      ForecastDataController().deleteInLocalData()
      // persist changes
      PR2CoreDataStack.sharedInstance.saveContext()
   }

   func testreadFromServer() {
      let expectation = self.expectationWithDescription("check in network connection can be made")
      
      ForecastNetworkController().readFromServer { (success) -> Void in
         if !success {
            XCTFail()
         }
         expectation.fulfill()
      }
      self.waitForExpectationsWithTimeout(30.0, handler: nil)
   }
   
   func testreadFromServerStubbed() {
      
      // TODO
      
      let expectation = self.expectationWithDescription("check in network connection can be made")
      
      ForecastNetworkController().readFromServer { (success) -> Void in
         if !success {
            XCTFail()
         }
         expectation.fulfill()
      }
      self.waitForExpectationsWithTimeout(30.0, handler: nil)
   }
   
}
