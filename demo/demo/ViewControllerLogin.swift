//
//  ViewControllerLogin.swift
//  demo
//
//  Created by Anil Kumar BP on 12/15/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation

import UIKit

class ViewControllerLogin: UIViewController {
    
    
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet weak var userBox: UITextField!
    @IBOutlet weak var passBox: UITextField!
    @IBOutlet weak var keyBox: UITextField!
    @IBOutlet weak var secretBox: UITextField!
    
    var platform: Platform?
    
    @IBAction func login(sender: AnyObject) {
        
        
        var rcsdk = SDK(appKey: keyBox.text, appSecret: secretBox.text, server: SDK.RC_SERVER_SANDBOX)
        var platform = rcsdk.platform()
        self.platform = platform
        platform.login(userBox.text, ext:"101", password: passBox.text)
        
        if platform.isAuthorized() {
            performSegueWithIdentifier("loginToMain", sender: nil)
        } else {
            //            shakeButton(sender)
        }
        
    }
    
    
    @IBAction func setValues(sender: UIButton) {
        userBox.text = "15856234190"
        passBox.text = "sandman1!"
        keyBox.text = "MNJx4H4cTR-02_zPnsTJ5Q"
        secretBox.text = "7CJKigzBTzOvzTDPP1-C3AARDYohOlSaCLcvgzpNZUzw"
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // Hides the keyboard when finished editting
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var textField: UITextField!
    
    // Sets variables in another ViewController from the current one
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "loginToMain" {
            var tabBarC : UITabBarController = segue.destinationViewController as! UITabBarController
            var desView: ViewControllerPhone = tabBarC.viewControllers?.first as! ViewControllerPhone
            if let check = platform {
                desView.platform = check
            }
            
            
        }
        
    }
    
    
}