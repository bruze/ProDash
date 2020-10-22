//
//  FlowTests.swift
//  ProDashTests
//
//  Created by Bruno Garelli on 10/19/20.
//

import XCTest
@testable import ProDash

class FlowTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDashboardFlowConsistenceOnUserLoggedWithAlias() {
        testCoordinatorsConsistenceOnLogWith(alias: "test")
    }

    func testDashboardFlowConsistenceOnUserLoggedAsGuest() {
        testCoordinatorsConsistenceOnLogWith(alias: "")
    }
    
    private func testCoordinatorsConsistenceOnLogWith(alias: String) {
        let main = MainCoordinator(navigationController: UINavigationController())
        XCTAssertTrue(main.childCoordinators.count == 1)
        XCTAssertTrue(main.childCoordinators.first is HomeCoordinator)
        main.services?.userManager.logUser(with: alias)
        let home = (main.childCoordinators.first as? HomeCoordinator)
        home?.userDidLog()
        /// Home flow exited after user logged or guest
        XCTAssertNil(home)
        XCTAssertTrue(main.navigationController.children.count == 1)
        XCTAssertTrue(main.navigationController.children.first is DashboardController)
    }
    
    func testSearchCoordinatorInitedOnce() {
        let main = MainCoordinator(navigationController: UINavigationController())
        main.services?.userManager.logUser(with: "")
        let home = (main.childCoordinators.first as? HomeCoordinator)
        home?.userDidLog()
        
        
        let waiter = XCTWaiter()
        let expect = expectation(for: NSPredicate(value: main.navigationController.children.filter({ $0 is DashboardController }).count == 1), evaluatedWith: main) {
            /// Must assure the view is loaded due we need to access container view inside DashboardController
            (main.navigationController.children.filter({ $0 is DashboardController }).first as? DashboardController)?.loadView()
            
            let dash = (main.childCoordinators.first as? DashboardCoordinator)
            dash?.sent(action: .search)
            
            XCTAssertTrue(dash?.childCoordinators.count == 1)
            XCTAssertTrue(dash?.childCoordinators.first is SearchCoordinator)
            /// Send search action again to test coordinator is not inited again
            dash?.sent(action: .search)
            XCTAssertTrue(dash?.childCoordinators.count == 1)
            XCTAssertTrue(dash?.childCoordinators.first is SearchCoordinator)
            return true
        }
        waiter.wait(for: [expect], timeout: 2.0)
    }
}
