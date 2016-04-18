//
//  SplashViewController.swift
//  SkyPablo
//
//  Created by Pablo Roca Rozas on 18/3/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lblInternetSlow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(self.PR2NetworkingtimerRequestReached),
            name: PR2NetworkingNotifications.slowInternet,
            object: nil
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: PR2NetworkingDelegate
    
    func PR2NetworkingtimerRequestReached()
    {
        self.lblInternetSlow.hidden = false
        self.lblInternetSlow.text = NSLocalizedString("ErrMsgSlowInternet", comment: "")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
