//
//  DashboardRequirements.swift
//  ProDashUITests
//
//  Created by Bruno Garelli on 10/19/20.
//

import XCTest

protocol DashboardRequirements {
    func testDashboardAppeared()
}

extension DashboardRequirements {
    func givenTheAppIsLaunched() {
        XCUIApplication().launch()
    }
    
    func testNavigationBarIsNotHidden() {
        let bars = XCUIApplication().navigationBars
        XCTAssertTrue(bars.count == 1)
    }
    
    func testNavigationBarHasSearchButton() {
        
    }
    
    func testNavigationBarHasFavoritesButton() {
        
    }
}
