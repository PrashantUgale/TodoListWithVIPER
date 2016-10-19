//
//  TodoMVCUITests.swift
//  TodoMVCUITests
//
//  Created by Prashant Ugale on 10/19/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import XCTest
import SBTUITestTunnel

class TodoMVCUITests: XCTestCase {
    var app: SBTUITunneledApplication!
        
    override func setUp() {
        super.setUp()
        // Create app with SBTUITunneledApplication and launch it
        app = SBTUITunneledApplication()
        app.launchTunnel()
        continueAfterFailure = false
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddTodo() {
        
        // Create matcher for the URL
        let matcher = SBTRequestMatch.URL("/login",method:"POST")
        
        // Create stub with the json file with request code
        app.stubRequestsMatching(matcher, returnJsonNamed:"login_response.json", returnCode:200 ,responseTime:SBTUITunnelStubsDownloadSpeed3G)

        // Set the expections
        let expectation = expectationWithDescription("Query timed out.");
        
        // wait for the response matching
        app.waitForMonitoredRequestsMatching(matcher,timeout:1, completionBlock:{ result in
            // make expections fulfill
            expectation.fulfill();
        })
        
        
        app.textFields["Email"].typeText("test@email.com")
        
        UIPasteboard.generalPasteboard().string = "password"
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.pressForDuration(1.1)
        app.menuItems["Paste"].tap()
        app.navigationBars["Login"].buttons["Done"].tap()
        
        // Wait until the expection fulfill for time duration
        waitForExpectationsWithTimeout(10, handler:nil)
        
        // Then set the asserts
        XCTAssert(app.staticTexts["Todo List"].exists == true)
        
    }
    
}
