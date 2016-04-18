//
//  MainViewController.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 17/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import UIKit
import SwiftDate

class MainViewController: UIViewController, UITableViewDelegate {

   //UI
   @IBOutlet weak var viewTable: UITableView!
   //UI
   
   let ItemsNetp  = ForecastNetworkController()
   let ItemsDatap = ForecastDataController()
   
   private let reuseIdentifier = "cell"
   
   var refreshControl: UIRefreshControl!
   var searchPredicate: NSPredicate?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.view.backgroundColor = Colors.defaultColor
      // main title
      self.title = NSLocalizedString("TitleMain", comment: "")
      
      // Register cell classes
      viewTable!.registerNib(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
      
      self.refreshControl = UIRefreshControl()
      self.refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("Pull to refresh", comment: ""))
      self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
      self.viewTable.addSubview(self.refreshControl)
      
      self.searchPredicate = nil
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      self.viewTable.reloadData()
   }
   
   // MARK: - Custom methods
   
   func refresh(sender:AnyObject) {
      // clear also cache
      NSURLCache.sharedURLCache().removeAllCachedResponses()
      self.ItemsNetp.readFromServer { (success) -> Void in
         self.refreshControl.endRefreshing()
         if (success) {
            self.reloadData()
         } else {
            PR2Common().simpleAlert(NSLocalizedString("ErrMsgLoadItemsTitle", comment: ""), message: NSLocalizedString("ErrMsgLoadItemsMsg", comment: ""))
         }
      }
      
      self.ItemsDatap.readFromLocalData(self.searchPredicate) { (success) -> Void in
      }
   }
   
   func reloadData() {
      self.ItemsDatap.readFromLocalData(self.searchPredicate) { (success) -> Void in
      }
      self.viewTable.reloadData()
   }
   
   // MARK: - Table view data source
   
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if let records = self.ItemsDatap.fetchedResultsController.fetchedObjects {
         return records.count
      } else {
         return 0
      }
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ForecastTableViewCell
      
      let item = self.ItemsDatap.fetchedResultsController.objectAtIndexPath(indexPath) as! CDEForecasts
      
      if let image = item.icon {
         let imageurl = EndPoints.image + image + ".png"
         cell.viewImage.PR2ImageFromNetwork(imageurl)
      } else {
         cell.viewImage = nil
      }
      let wdate = NSDate(timeIntervalSince1970: item.dt!.doubleValue)
      let wdateRegion = DateInRegion(absoluteTime: wdate, region: nil)
      let weekday = wdateRegion.weekdayName
      
      let datestring = String(format: "%@ %02d:%02d", weekday, wdate.hour, wdate.minute)
      
      cell.lblDateAndTime.text = datestring
      cell.lblwdescription.text = item.wdescription
      cell.lbltemp_max.text = String(format: "%0.1fº C", item.temp_max!.doubleValue)
      cell.lbltemp_min.text = String(format: "%0.1fº C", item.temp_min!.doubleValue)
      cell.lblwindspeed.text = String(format: "%0.1f m/s", item.windspeed!.doubleValue)
      cell.lblclouds.text = String(format: "clouds: %2d %%", item.clouds!.intValue)
      return cell
   }


}
