//
//  Transaction.swift
//  src
//
//  Created by Anil Kumar BP on 11/17/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation

class ApiResponse {
    
    // Constants
    internal var jsonAsArray = [String: AnyObject]()
    internal var jsonAsObject: AnyObject? = AnyObject?()
    internal var multipartTransactions: AnyObject? = AnyObject?()
    internal var request: NSMutableURLRequest?
    internal var raw: AnyObject? = AnyObject?()
    internal var jsonAsString: String = ""
    
    // Data Response Error Initialization
    private var data: NSData?
    private var response: NSURLResponse?
    private var error: NSError?
    private var dict: NSDictionary?
    
    init(request: NSMutableURLRequest, status: Int = 200, data: NSData?, response: NSURLResponse?, error: NSError?, dict: NSDictionary?) { // data via constructor
        self.request = request
        self.data = data
        self.response = response
        self.error = error
        self.dict = dict
    }
    
    func getText() -> String {
        if let check = data {
            return check.description
        } else {
            return "No data."
        }
    }
    
    func getRaw() -> Any {
        return raw
    }
    
    func getJson() -> [String: AnyObject] {
        return jsonAsArray
    }
    
    func getJsonAsString() -> String {
        return jsonAsString
    }
    
    func getMultipart() -> AnyObject? {
        return self.multipartTransactions
    }
    
    func isOK() -> Bool {
        return (self.response as! NSHTTPURLResponse).statusCode / 100 == 2
    }
    
    func getError() -> NSError? {
        return error
    }
    
    func getData() -> NSData? {
        return self.data
    }
    func getDict() -> Dictionary<String,NSObject> {
        return self.dict as! Dictionary<String, NSObject>
    }
    
    func getRequest() -> NSMutableURLRequest? {
        return request
    }
    
    func getResponse() -> NSURLResponse? {
        return response
    }
    
    func isContentType(type: String) -> Bool {
        return false
    }
    
    func getContentType() {
        
    }
    
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
}