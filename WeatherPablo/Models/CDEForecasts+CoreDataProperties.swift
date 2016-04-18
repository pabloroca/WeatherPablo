//
//  CDEForecasts+CoreDataProperties.swift
//  
//
//  Created by Pablo Roca Rozas on 17/4/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CDEForecasts {

   @NSManaged var clouds: NSNumber?
   @NSManaged var dt: NSNumber?
   @NSManaged var icon: String?
   @NSManaged var pressure: NSNumber?
   @NSManaged var temp_max: NSNumber?
   @NSManaged var temp_min: NSNumber?
   @NSManaged var wdescription: String?
   @NSManaged var windspeed: NSNumber?

}
