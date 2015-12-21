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
    ///FIXME This method should throw ApiException if something went wrong or apiresponse.ok is false
    public func send(request: NSMutableURLRequest) -> ApiResponse {

        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        var apiresponse = ApiResponse(request: request, data: data, response: response, error: error)
        return apiresponse
    }
    
    
    /// Generic HTTP request with completion handler
    ///
    /// :param: options         List of options for HTTP request
    /// :param: completion      Completion handler for HTTP request
    /// @resposne: ApiResponse  Callback
    ///FIXME Completion handler should always be called with 2 parameters: apiResponse and apiError (which can be nil)
    public func send(request: NSMutableURLRequest, completionHandler: (response: ApiResponse) -> Void) {

        var semaphore = dispatch_semaphore_create(0)
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
            (data, response, error) in
            var apiresponse = ApiResponse(request: request, data: data, response: response, error: error)
            //TODO var apierror = apiresponse.isOK() ? ApiException(apiresponse) : nil
            completionHandler(response:apiresponse) //TODO apierror
            dispatch_semaphore_signal(semaphore)
        }
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
    }
    

    
    /// func createRequest()
    ///
    /// @param: method      NSMutableURLRequest
    /// @param: url         list of options
    /// @param: query       query ( optional )
    /// @param: body        body ( optional )
    /// @param: headers     headers
    /// @response: NSMutableURLRequest
    public func createRequest(method: String, url: String, query: [String: String]?=nil, body: [String: AnyObject]?, headers: [String: String]!) -> NSMutableURLRequest {

        var parse = parseProperties(method, url: url, query: query, body: body, headers: headers)
        
        // Create a NSMutableURLRequest
        var request = NSMutableURLRequest()
        if let nsurl = NSURL(string: url + (parse["query"] as! String)) {
            request = NSMutableURLRequest(URL: nsurl)
            request.HTTPMethod = method
            request.HTTPBody = parse["body"]!.dataUsingEncoding(NSUTF8StringEncoding)
                for (key,value) in parse["headers"] as! Dictionary<String, String> {
                    request.setValue(value, forHTTPHeaderField: key)
                }
        }
        return request
    }
    
    // func parseProperties
    /// @param: method          NSMutableURLRequest
    /// @param: url             list of options
    /// @param: query           query ( optional )
    /// @param: body            body ( optional )
    /// @param: headers         headers
    /// @response: Dictionary   
    internal func parseProperties(method: String, url: String, query: [String: String]?=nil, body: [String: AnyObject]?, headers: [String: String]!) -> [String: AnyObject] {
        
        var parse = [String: AnyObject]()
        var truncatedBodyFinal: String = ""
        var truncatedQueryFinal: String = ""
        var queryFinal: String = ""
        
        // Check for query
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
        }
        
        // Check for Body
        var bodyString: String
        var bodyFinal: String = ""
        
        // Check if the body is empty
        if (body == nil || body?.count == 0) {
            truncatedBodyFinal = ""
        }
        else {
            if (headers["Content-type"] == "application/x-www-form-urlencoded;charset=UTF-8") {
                if let q = body {
                    bodyFinal = ""
                    for key in q.keys {
                        bodyFinal = bodyFinal + key + "=" + (q[key]! as! String) + "&"
                    }
                    truncatedBodyFinal = bodyFinal.substringToIndex(bodyFinal.endIndex.predecessor())
                }
            }
            else {
                if let json: AnyObject = body as AnyObject? {                    
                    bodyFinal = Util.jsonToString(json as! [String : AnyObject])
                    truncatedBodyFinal = bodyFinal
                }
            }
        }
        
        parse["query"] = truncatedQueryFinal
        parse["body"] = truncatedBodyFinal
        parse["headers"] = [String: [String: String]]()
        // check for Headers
        if headers.count == 1 {
            var headersFinal = [String: String]()
            headersFinal["Content-Type"] = "application/json"
            headersFinal["Accept"] = "application/json"
            parse["headers"] = headersFinal
        }
        else {
         parse["headers"] = headers
        }
        return parse
    }
}


