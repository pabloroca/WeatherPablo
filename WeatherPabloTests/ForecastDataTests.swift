//
//  ForecastDataTests.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 18/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import XCTest
@testable import WeatherPablo

class ForecastDataTests: XCTestCase {
   
   var itemsDatap:ForecastDataController? = nil
   
   override func setUp() {
      super.setUp()
      
      self.itemsDatap = ForecastDataController()
      
      // clear database
      self.testdeleteInLocalData()
      // load data into coreData
// TODO      self.initData()
   }
   
   override func tearDown() {
      super.tearDown()
      
      // clear database
      self.testdeleteInLocalData()
      // persist changes
      PR2CoreDataStack.sharedInstance.saveContext()
   }
   
   func initData() {
      if let info = NSBundle(forClass: self.dynamicType).infoDictionary {
         let data: NSData = info["MyData"] as! NSData
         ForecastDataController().addIntoLocalData(data, completionHandler: { (success) -> Void in
         })
      }
   }
   
   func testreadFromLocalData() {
      self.itemsDatap!.readFromLocalData(nil) { (success) -> Void in
         if success {
            XCTAssert(true, "Pass")
         } else {
            XCTFail()
         }
      }
   }
   
   func testreadFromLocalDataandData() {
      var numrecords = 0
      
      self.itemsDatap!.readFromLocalData(nil) { (success) -> Void in
         if let records = self.itemsDatap!.fetchedResultsController.fetchedObjects {
            numrecords = records.count
         } else {
            numrecords = 0
         }
         
         if (success && numrecords > 0) {
            XCTAssert(true, "Pass")
         } else {
            XCTFail()
         }
      }
   }
   
   func testdeleteInLocalData() {
      var numrecords = 0
      
      self.itemsDatap!.deleteInLocalData()
      
      self.itemsDatap!.readFromLocalData(nil) { (success) -> Void in
         if let records = self.itemsDatap!.fetchedResultsController.fetchedObjects {
            numrecords = records.count
         } else {
            numrecords = 0
         }
         
         if (success && numrecords == 0) {
            XCTAssert(true, "Pass")
         } else {
            XCTFail()
         }
      }
      
   }
   
}
