//
//  Client.swift
//  demo
//
//  Created by Vincent Tseng on 8/17/15.
//  Copyright (c) 2015 Vincent Tseng. All rights reserved.
//

import Foundation

class Client {
    
    internal var useMock: Bool = false
    internal var appName: String
    internal var appVersion: String
    
    internal var mockRegistry: AnyObject?
    
    init(appName: String = "", appVersion: String = "") {
        self.appName = appName
        self.appVersion = appVersion
    }
    
    func getMockRegistry() -> AnyObject? {
        return mockRegistry
    }
    
    func useMock(flag: Bool = false) -> Client {
        self.useMock = flag
        return self
    }
    
    func send() {
        
    }
    
    func sendReal() {
        
    }
    
    func sendMock() {
        
    }
    
    
    // makes a request
    func requestFactory() {
        
    }
    
    func getRequestHeaders() {
        
    }
    
    func parseProperties() {
        
    }
    
}