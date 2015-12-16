//
//  ViewControllerPhone.swift
//  demo
//
//  Created by Anil Kumar BP on 12/15/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerPhone: UIViewController {
    
    @IBOutlet var number: UILabel!
    @IBOutlet var fromNumber: UITextField!
    @IBOutlet var message: UITextField!
    @IBOutlet var status: UILabel!
    @IBOutlet var toNumber: UITextField!
    
    var platform: Platform!
    
    @IBAction func numberPressed(sender: AnyObject) {
        number.text = number.text! + sender.titleLabel!!.text!
    }
    
    @IBAction func backspace() {
        if (number.text! != "") {
            number.text = dropLast(number.text!)
        }
    }
    
    @IBAction func call() {
        // ringout
        platform.post("/account/~/extension/~/ringout", body :
            [ "to": ["phoneNumber": "18315941779"],
                "from": ["phoneNumber": "15856234190"],
                "callerId": ["phoneNumber": ""],
                "playPrompt": "true"
            ])
            {
                (transaction) in
                println("Response is :")
                println(transaction.getResponse())
                println("API response is :")
                println(transaction.getDict())
        }
        
        //        println(platform.getCallLog(true))
        //        var secondTab = self.tabBarController?.viewControllers![1] as! ViewControllerLog
        //        secondTab.label.text = secondTab.label.text! + "hi"
        
    }
    
    func refreshHistory() {
        
    }
    
    @IBAction func pressSMSButton(sender: AnyObject) {
        if message.text! != "" {
            //            platform.postSms(message.text!, to: number.text!)
            
            //            var toNumber = "18315941779"
            //
            //            var bodyString = "{" +
            //                "\"to\": [{\"phoneNumber\": " +
            //                "\"" + toNumber + "\"}]," +
            //                "\"from\": {\"phoneNumber\": \"" + "158586234190" +
            //                "\"}," + "\"text\": \"" + message.text! + "\"" + "}"
            
            platform.post("/account/~/extension/~/sms", body :
                [   "to": [["phoneNumber": "18315941779"]],
                    "from": ["phoneNumber": fromNumber],
                    "text": message.text!
                ])
                {
                    (transaction) in
                    println("Response is :")
                    println(transaction.getResponse())
                    println("API response is :")
                    println(transaction.getDict())
                    
            }
        }
        
    }
    
    @IBOutlet var labelPassedData: UILabel!
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        fromNumber.text = ""
        
        var secondTab = self.tabBarController?.viewControllers![1] as! ViewControllerLog
        secondTab.platform = self.platform
        
        var subscription = Subscription(platform: platform)
        subscription.addEvents(
            [
                "/restapi/v1.0/account/~/extension/~/presence",
                "/restapi/v1.0/account/~/extension/~/message-store"
            ])
        
        
        subscription.register()
            {
                (transaction) in
                println("Response is :")
                println(transaction.getResponse())
                println("API response is :")
                println(transaction.getDict())
                
        }
        
        subscription.setMethod({
            (arg) in
            if let check = (self.stringToDict(arg) as? NSDictionary) {
                if let body = check["body"] as? NSDictionary {
                    if let status = body["telephonyStatus"] as? String {
                        switch status {
                        case "CallConnected":
                            self.status.text = "Call Connected"
                            self.status.backgroundColor = UIColor.greenColor()
                        case "NoCall":
                            self.status.text = "No Call"
                            self.status.backgroundColor = UIColor.redColor()
                        case "Ringing":
                            self.status.text = "Ringing"
                            self.status.backgroundColor = UIColor.yellowColor()
                            
                        default:
                            println("error")
                        }
                    }
                }
                
            }
        })
        
    }
    
    private func stringToDict(string: String) -> NSDictionary {
        var data: NSData = string.dataUsingEncoding(NSUTF8StringEncoding)!
        
        return NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}