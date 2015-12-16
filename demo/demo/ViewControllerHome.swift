//
//  ViewControllerHome.swift
//  demo
//
//  Created by Anil Kumar BP on 12/15/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerHome: UIViewController {
    
    
    
    @IBAction func authneticate(sender: AnyObject) {
        performSegueWithIdentifier("authenticate", sender: self)
        
    }
    
    // Hides the keyboard when finished editting
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func documentation(sender: AnyObject) {
        var url:NSURL
        url = NSURL(string: "https://developer.ringcentral.com/api-docs/latest/index.html")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func apiExplorer(sender: AnyObject) {
        var url:NSURL
        url = NSURL(string: "http://ringcentral.github.io/api-explorer/")!
        UIApplication.sharedApplication().openURL(url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}