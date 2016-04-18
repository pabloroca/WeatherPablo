//
//  PR2Common.swift
//
//  Created by Pablo Roca Rozas on 24/1/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

// Common functions for any project

import Foundation
import UIKit

/// Commom functions for any project
public class PR2Common {
    
    /**
     Displays network activity indicator in status bar
     */
    func showNetworkActivityinStatusBar() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    /**
     Hides network activity indicator in status bar
     */
    func hideNetworkActivityinStatusBar() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    /**
     Simple alert view
     
     - parameter title: title of the alert.
     - parameter message: message to show in the alert.
     
     */
    func simpleAlert(title: String, message: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainWindow = appDelegate.window!
        
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        mainWindow.rootViewController!.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

