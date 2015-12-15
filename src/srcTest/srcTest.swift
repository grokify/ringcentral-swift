//
//  srcTest.swift
//  srcTest
//
//  Created by Anil Kumar BP on 12/14/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Cocoa
import XCTest
import src



class srcTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor() {
//        var sdk = SDK(appKey: "MNJx4H4cTR-02_zPnsTJ5Q", appSecret: "7CJKigzBTzOvzTDPP1-C3AARDYohOlSaCLcvgzpNZUzw", server: "https://platform.devtest.ringcentral.com", appName: "Sample", appVersion: SDK.VERSION)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
