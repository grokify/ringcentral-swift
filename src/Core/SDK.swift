//
//  SDK.swift
//  src
//
//  Created by Anil Kumar BP on 11/17/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation

// Object representation of a Standard Development Kit for RingCentral
public class SDK {
    
    // Set constants for SANDBOX and PRODUCTION servers.
    public static var VERSION: String = ""
    public static var RC_SERVER_PRODUCTION: String = "https://platform.ringcentral.com"
    public static var RC_SERVER_SANDBOX: String = "https://platform.devtest.ringcentral.com"
    
    // Platform variable, version, and current Subscriptions
    var _platform: Platform
    let server: String
    var _client: Client
    var serverVersion: String!
    var versionString: String!
    var logger: Bool = false
    
    
    /// Constructor for the SDK object
    ///
    /// :param: appKey      The appKey of your app
    /// :param: appSecet    The appSecret of your app
    /// :param: server      Choice of PRODUCTION or SANDBOX
    /// @param: appName     appName ( optional )
    /// @param: appVersion  appVersion ( optional )
    public init(appKey: String, appSecret: String, server: String, appName: String?="", appVersion: String?="") {
        self._client = Client()
        _platform = Platform(client: self._client, appKey: appKey, appSecret: appSecret, server: server, appName: appName!, appVersion: appVersion!)
        self.server = server
    }
    
    
    /// Returns the Platform with the specified appKey and appSecret.
    
    /// :returns: A Platform to access the methods of the SDK
    public func platform() -> Platform {
        return self._platform
    }
    
    //  Create a subscription.
    
    //  :returns: Subscription object that has been currently created
    public func createSubscription() -> Subscription {
        return Subscription(platform: self._platform)
    }
    
    //  Create a multi-part builder
    public func createMultipartBuilder() -> MultipartBuilder {
        return MultipartBuilder()
    }
    
    
}