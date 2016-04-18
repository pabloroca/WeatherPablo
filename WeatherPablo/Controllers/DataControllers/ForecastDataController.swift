//
//  ForecastDataController.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 17/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import Foundation
import UIKit

import CoreData
import SwiftyJSON

/// CRUD operations for Items in CoreData
public class ForecastDataController {
   
   var fetchedResultsController = NSFetchedResultsController()
   
   /// order by date
   lazy var sortDescriptor: NSSortDescriptor = {
      var sd = NSSortDescriptor(key: "dt",
                                ascending: true)
      return sd
   }()
   
   /**
    Reads Items from CoreData
    
    - parameter predicate: predicate to use in search.
    
    - returns: completionHandler: (success: Bool).
    */
   public func readFromLocalData(
      predicate: NSPredicate?,
      completionHandler: (success: Bool) -> Void)
   {
      let fetchRequest = NSFetchRequest(entityName: "CDEForecasts")
      fetchRequest.sortDescriptors = [sortDescriptor]
      fetchRequest.predicate = predicate
      
      self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                 managedObjectContext: PR2CoreDataStack.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
      
      do {
         try self.fetchedResultsController.performFetch()
         completionHandler(success: true)
      } catch {
         completionHandler(success: false)
      }
   }
   
   /// deletes all Items in CoreData
   public func deleteInLocalData() {
      PR2CoreDataStack.sharedInstance.deleteAllData("CDEForecasts")
   }
   
   /**
    Add Items into CoreData.
    
    - parameter data: The data to add (NSData).
    
    - returns: completionHandler: (success: Bool).
    */
   public func addIntoLocalData(
      data: NSData?,
      completionHandler: (success: Bool) -> Void)
   {
      self.deleteInLocalData()
      
      let json = JSON(data: data!)
      
      for (_,subJson):(String, JSON) in json["list"] {
         
         let item = CDEForecasts.init(managedObjectContext: PR2CoreDataStack.sharedInstance.managedObjectContext)

         // we protect agains nil objects in JSON
         
         if let clouds = subJson["clouds"]["all"].double {
            item.clouds = clouds
         } else {
            item.clouds = 0
         }
         if let dt = subJson["dt"].int64 {
            item.dt = NSNumber(longLong: dt)
         } else {
            item.dt = 0
         }
         if let icon = subJson["weather"][0]["icon"].string {
            item.icon = icon
         } else {
            item.icon = ""
         }
         if let pressure = subJson["main"]["pressure"].double {
            item.pressure = pressure
         } else {
            item.pressure = 0
         }
         if let temp_max = subJson["main"]["temp_max"].double {
            item.temp_max = temp_max
         } else {
            item.temp_max = 0
         }
         if let temp_min = subJson["main"]["temp_min"].double {
            item.temp_min = temp_min
         } else {
            item.temp_min = 0
         }
         if let wdescription = subJson["weather"][0]["description"].string {
            item.wdescription = wdescription
         } else {
            item.wdescription = ""
         }
         if let windspeed = subJson["wind"]["speed"].double {
            item.windspeed = windspeed
         } else {
            item.windspeed = 0
         }
      
      }
      
      // update cache info
      PR2CoreDataStack.sharedInstance.deleteAllData("CDECache")
      let cache = CDECache.init(managedObjectContext: PR2CoreDataStack.sharedInstance.managedObjectContext)
      cache.lastcheck = NSDate().timeIntervalSince1970
      
      // save context
      do {
         try PR2CoreDataStack.sharedInstance.managedObjectContext.save()
         completionHandler(success: true)
      } catch {
         completionHandler(success: false)
      }
   }
   
   
}