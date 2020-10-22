//
//  GeneralRequirements.swift
//  ProDashUITests
//
//  Created by Bruno Garelli on 10/22/20.
//

import XCTest

protocol GeneralRequirements {
    func givenTheAppIsLaunched()
}

extension GeneralRequirements {
    func givenTheAppIsLaunched() {
        XCUIApplication().launch()
    }
}
