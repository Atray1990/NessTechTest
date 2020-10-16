//
//  ListViewScreen.swift
//  TestProjectDataTests
//
//  Created by shashank atray on 16/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import XCTest
@testable import TestProjectData

class ListViewScreen: XCTestCase {
    
    var viewController = CartViewController()
    
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
    
    func testOffersVC() {
        // Navigate to the Offers View Controller
        
        let app = XCUIApplication()
        app.children(matching: .window)
            .element(boundBy: 0)
            .children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element(boundBy: 2)
            .children(matching: .other)
            .element(boundBy: 2)
            .tap()
        
        let offerTitle: XCUIElement = app.navigationBars["Countries"].staticTexts["Countries"]
        XCTAssert(offerTitle.exists, "Did not navigate to offers view controller")
    }
    
    func testOfferDetailVC() {
        //Navigate to Offer Detail View Controller and back
        let app = XCUIApplication()
        app.children(matching: .window)
            .element(boundBy: 0)
            .children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element(boundBy: 2)
            .children(matching: .other)
            .element(boundBy: 2)
            .tap()
        
        let firstCell: XCUIElement = app.tables.cells.element(boundBy: 0)
        waitForExistence(object: firstCell)
        firstCell.tap()
        
        app.navigationBars[viewController.testPackage?.name ?? ""].buttons["Back"].tap()
        XCTAssert(firstCell.exists, "Did not navigate back to Offers")
    }
    
    func waitForExistence(object: XCUIElement) {
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: object, handler: nil)
        waitForExpectations(timeout: 5, handler: { error in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}
