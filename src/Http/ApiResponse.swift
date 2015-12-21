//
//  Transaction.swift
//  src
//
//  Created by Anil Kumar BP on 11/17/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation

public class ApiResponse {
    
    // ApiResponse Constants
    internal var multipartTransactions: AnyObject? = AnyObject?()
    internal var request: NSMutableURLRequest?
    internal var raw: AnyObject? = AnyObject?()

    
    // Data Response Error Initialization
    private var data: NSData?
    private var response: NSURLResponse?
    private var error: NSError?
    private var dict: NSDictionary?

    /// Constructor for the ApiResponse
    ///
    /// @param: request     NSMutableURLRequest
    /// @param: data        Instance of NSData
    /// @param: response    Instance of NSURLResponse
    /// @param: error       Instance of NSError
    init(request: NSMutableURLRequest, status: Int = 200, data: NSData?, response: NSURLResponse?, error: NSError?) {
        self.request = request
        self.data = data
        self.response = response
        self.error = error
    }
    
    public func getText() -> String {
        if let check = data {
            return check.description
        } else {
            return "No data."
        }
    }
    
    public func getRaw() -> Any {
        return raw
    }

    public func getMultipart() -> AnyObject? {
        return self.multipartTransactions
    }
    
    public func isOK() -> Bool {
        return ((self.response as! NSHTTPURLResponse).statusCode >= 200 && (self.response as! NSHTTPURLResponse).statusCode < 300)
    }
    
    public func getError() -> NSError? {
        return error
    }
    
    public func getData() -> NSData? {
        return self.data
    }
    public func getDict() -> Dictionary<String,NSObject> {
        var errors: NSError?
        self.dict = NSJSONSerialization.JSONObjectWithData(self.data!, options: nil, error: &errors) as? NSDictionary
        return self.dict as! Dictionary<String, NSObject>
    }
    
    public func getRequest() -> NSMutableURLRequest? {
        return request
    }
    
    public func getResponse() -> NSURLResponse? {
        return response
    }
    
    public func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
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
