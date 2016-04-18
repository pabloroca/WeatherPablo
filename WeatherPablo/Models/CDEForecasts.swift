//
//  CDEForecasts.swift
//  
//
//  Created by Pablo Roca Rozas on 17/4/16.
//
//

import Foundation
import CoreData

@objc(CDEForecasts)
class CDEForecasts: NSManagedObject {

   // MARK: - Class methods
   /// Entity name
   class func entityName () -> String {
      return "CDEForecasts"
   }
   
   /**
    Entity description
    
    - parameter managedObjectContext: Managed Object Context.
    
    - returns: Entity description (NSEntityDescription).
    */
   class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
      return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
   }
   
   // MARK: - Life cycle methods
   
   /**
    Designated initializer
    
    - parameter entity: Entity description.
    - parameter context: Managed Object Context.
    */
   override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
      super.init(entity: entity, insertIntoManagedObjectContext: context)
   }
   
   /**
    Convenience initializer
    
    - parameter context: Managed Object Context.
    */
   convenience init(managedObjectContext: NSManagedObjectContext!) {
      let entity = CDEForecasts.entity(managedObjectContext)
      self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
   }
   
}
