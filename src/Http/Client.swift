//
//  Client.swift
//  src
//
//  Created by Anil Kumar BP on 11/17/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation


public class Client {
    
    // Client Variables
    internal var useMock: Bool = false
    internal var appName: String
    internal var appVersion: String
    internal var mockRegistry: AnyObject?
    
    // Client Constants
    var contentType = "Content-Type"
    var jsonContentType = "application/json"
    var multipartContentType = "multipart/mixed"
    var urlencodedContentType = "application/x-www-form-urlencoded"
    var utf8ContentType = "charset=UTF-8"
    var accept = "Accept"
    
    
    /// Constructor for the Client
    ///
    /// :param: appName        The appKey of your app
    /// :param: appVersion     The appSecret of your app
    init(appName: String = "", appVersion: String = "") {
        self.appName = appName
        self.appVersion = appVersion
    }
   
    /// Generic HTTP request
    ///
    /// :param: options         List of options for HTTP request
    /// :param: completion      Completion handler for HTTP request
    /// @response: ApiResposne
    public func send(request: NSMutableURLRequest) -> ApiResponse {

        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        println((response as! NSHTTPURLResponse).statusCode)
        var apiresponse = ApiResponse(request: request, data: data, response: response, error: error)
        return apiresponse
    }
    
    
    /// Generic HTTP request with completion handler
    ///
    /// :param: options         List of options for HTTP request
    /// :param: completion      Completion handler for HTTP request
    /// @resposne: ApiResponse  Callback
    public func send(request: NSMutableURLRequest, completionHandler: (response: ApiResponse) -> Void) {
        
        println("inside sendReal :")
        var semaphore = dispatch_semaphore_create(0)
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
            (data, response, error) in
            var apiresponse = ApiResponse(request: request, data: data, response: response, error: error)
            completionHandler(response:apiresponse)
            dispatch_semaphore_signal(semaphore)
        }
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
    }
    
    
    /// func jsonToString()
    ///
    /// @param: json        Json Object
    /// @response           String
    public func jsonToString(json: [String: AnyObject]) -> String {
        var result = "{"
        var delimiter = ""
        for key in json.keys {
            result += delimiter + "\"" + key + "\":"
            var item: AnyObject? = json[key]
            if let check = item as? String {
                result += "\"" + check + "\""
            } else {
                if let check = item as? [String: AnyObject] {
                    result += jsonToString(check)
                } else if let check = item as? [AnyObject] {
                    result += "["
                    delimiter = ""
                    for item in check {
                        result += "\n"
                        result += delimiter + "\""
                        result += item.description + "\""
                        delimiter = ","
                    }
                    result += "]"
                } else {
                    result += item!.description
                }
            }
            delimiter = ","
        }
        result = result + "}"
        
        println("Body String is :"+result)
        return result
    }
    
    
    /// func createRequest()
    ///
    /// @param: method      NSMutableURLRequest
    /// @param: url         list of options
    /// @param: query       query ( optional )
    /// @param: body        body ( optional )
    /// @param: headers     headers
    /// @response: NSMutableURLRequest
    public func createRequest(method: String, url: String, query: [String: String]?=nil, body: [String: AnyObject]?, headers: [String: String]) -> NSMutableURLRequest {
        
        var truncatedBodyFinal: String = ""
        var truncatedQueryFinal: String = ""
        var queryFinal: String = ""
        
        if let q = query {
            queryFinal = "?"
            
            for key in q.keys {
                if(q[key] == "") {
                    queryFinal = "&"
                }
                else {
                    queryFinal = queryFinal + key + "=" + q[key]! + "&"
                }
            }
            truncatedQueryFinal = queryFinal.substringToIndex(queryFinal.endIndex.predecessor())
            println("The truncated queryFInal is :"+truncatedQueryFinal)
            
            println("Non-Empty Query List")
        }
        
        // Body
        var bodyString: String
        var bodyFinal: String = ""
        
        // Check if the body is empty
        if (body?.count == 0) {
            println("Body is Empty")
            truncatedBodyFinal = ""
            
        } else {
            
            // Check if body is for authentication
            if (headers["Content-type"] == "application/x-www-form-urlencoded;charset=UTF-8") {
                if let q = body {
                    bodyFinal = ""
                    for key in q.keys {
                        bodyFinal = bodyFinal + key + "=" + (q[key]! as! String) + "&"
                    }
                    truncatedBodyFinal = bodyFinal.substringToIndex(bodyFinal.endIndex.predecessor())
                    println(truncatedBodyFinal)
                }
            }
                
                // Format the body
            else {
                if let json: AnyObject = body as AnyObject? {
                    println("Non-Empty Body")
                    bodyFinal = jsonToString(json as! [String : AnyObject])
                    truncatedBodyFinal = bodyFinal
                    println(truncatedBodyFinal)
                }
                //                else if (json = body as String)
            }
        }
        
        
        // Create a NSMutableURLRequest
        var request = NSMutableURLRequest()
        
        // Get RID of these
        println("Inside Create Request")
        println("The url is :"+url)
        println("The queryFinal is :"+queryFinal)
        
        if let nsurl = NSURL(string: url + truncatedQueryFinal) {
            request = NSMutableURLRequest(URL: nsurl)
            request.HTTPMethod = method
            request.HTTPBody = truncatedBodyFinal.dataUsingEncoding(NSUTF8StringEncoding)
            for key in headers.keys {
                request.setValue(headers[key], forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
}
