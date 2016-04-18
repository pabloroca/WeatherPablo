//
//  AppDelegate.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 17/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import UIKit

@UIApplicationMain

/// Main App Delegate
class AppDelegate: UIResponder, UIApplicationDelegate {

   /// datamodel name (and also is the sqlite table created)
   let dataModel: String = "WeatherPablo"

   /// main window
   var window: UIWindow?
   /// main view controller
   var myMainViewController:MainViewController?
   /// has the main screen been launched?
   var isMainScreenLaunched: Bool = false
   /// timer for launch the main screen
   var timerStart = NSTimer()
   /// after how many seconds the main screen is launched
   let secondsTocontinueToMainScreen:Double = 3

   func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

      // initialize CoreData stack
      PR2CoreDataStack.sharedInstance
      
      // network logger
      PR2Networking.sharedInstance.logLevel = PR2NetworkingLogLevel.PR2NetworkingLogLevelInfo
      self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
      
      customizeAppearance()
      
      if let mainWindow = window {
         showSplash()
         mainWindow.makeKeyAndVisible()
         self.myMainViewController = MainViewController()
         let navigationController = UINavigationController(rootViewController: self.myMainViewController!)
         
         self.timerStart = NSTimer.scheduledTimerWithTimeInterval(self.secondsTocontinueToMainScreen, target: self, selector: #selector(AppDelegate.continueToMainScreen), userInfo: nil, repeats: false)
         
         ForecastNetworkController().readFromServer { [weak self] (success) -> Void in
            guard let strongSelf = self else { return }
            if (success) {
               strongSelf.timerStart.invalidate()
               if (!strongSelf.isMainScreenLaunched) {
                  mainWindow.rootViewController = navigationController
               }
               // minor delay for allowing load screen
               let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(0.3 * Double(NSEC_PER_SEC)))
               dispatch_after(time, dispatch_get_main_queue()) {
                  strongSelf.myMainViewController!.reloadData()
               }
            } else {
               PR2Common().simpleAlert(NSLocalizedString("ErrMsgLoadForecastTitle", comment: ""), message: NSLocalizedString("ErrMsgLoadForecastMsg", comment: ""))
            }
         }
         
      }
      
      return true
   }
   
   func continueToMainScreen() {
      self.timerStart.invalidate()
      self.isMainScreenLaunched = true
      // we give 1 second to be able to see message in splash screen
      let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(1 * Double(NSEC_PER_SEC)))
      dispatch_after(time, dispatch_get_main_queue()) {
         if let mainWindow = self.window {
            mainWindow.rootViewController = self.myMainViewController
         }
      }
   }

   func applicationWillResignActive(application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   }

   func applicationWillEnterForeground(application: UIApplication) {
      // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   }

   func applicationDidBecomeActive(application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
      // Saves changes in the application's managed object context before the application terminates.
      PR2CoreDataStack.sharedInstance.saveContext()
   }

   // MARK: - Splash screen
   func showSplash() {
      self.window!.rootViewController = SplashViewController()
   }
   
   // MARK: - Appearance
   
   func customizeAppearance() {
      UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
      UINavigationBar.appearance().barTintColor = Colors.defaultColor
      UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:Colors.defaultTextColor]
      UINavigationBar.appearance().tintColor = Colors.defaultTextColor
   }

}

