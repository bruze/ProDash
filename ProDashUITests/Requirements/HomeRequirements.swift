//
//  HomeRequirements.swift
//  ProDashUITests
//
//  Created by Bruno Garelli on 10/16/20.
//

import XCTest

protocol HomeRequirements {
    func testHomeAppeared()
}

extension HomeRequirements {
    
    func testNavigationBarIsHidden() {
        let bars = XCUIApplication().navigationBars
        XCTAssertTrue(bars.count == 0)
    }
    
    func testHomeHasAliasField() {
        XCTAssertTrue(XCUIApplication().textFields["alias"].exists)
    }
    
    func testHomeHasLoginButtonAndIsDisabledByDefault() {
        XCTAssertTrue(XCUIApplication().buttons["login"].exists)
        XCTAssertFalse(XCUIApplication().buttons["login"].isEnabled)
    }
    
    func testHomeHasSkipButton() {
        XCTAssertTrue(XCUIApplication().buttons["skip"].exists)
    }
}
