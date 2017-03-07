//
//  BoTree911Tests.swift
//  BoTree911Tests
//
//  Created by piyushMac on 03/03/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import XCTest

@testable import BoTree911

class BoTree911Tests: XCTestCase {
    
    var vc: LoginViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! LoginViewController
    }
    
    func testEmailValidation() {
        XCTAssert(false)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
