//
//  ViewControllerTest.swift
//  TestProjectDataTests
//
//  Created by shashank atray on 16/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import XCTest
@testable import TestProjectData

class ViewControllerTest: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHomeVC() {
        XCTContext.runActivity(named: "Home view screenshot") { activity in
            let screen = XCUIScreen.main
            let fullscreenshot = screen.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
        
        XCTContext.runActivity(named: "Check Navigation bar UI setup") { activity in
            let navBar: XCUIElement = app.navigationBars["Home"]
            activity.add(navBar.sayCheese())
            XCTAssert(navBar.exists, "Home navigation bar did not load")
        }
        
        XCTContext.runActivity(named: "Check button set up setup") { activity in
            let Enterlabel = self.app.staticTexts["Enter"]
            XCTAssertFalse(Enterlabel.exists)
            activity.add(Enterlabel.sayCheese())
            
            let exists = NSPredicate(format: "exists == true")
            expectation(for: exists, evaluatedWith: Enterlabel, handler: nil)

            app.buttons["Enter"].tap()
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssert(Enterlabel.exists)
            XCTAssert(Enterlabel.exists, "enter button is not present")
        }
    }
}
