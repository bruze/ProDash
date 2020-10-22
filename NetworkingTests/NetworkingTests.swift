//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Bruno Garelli on 10/19/20.
//

import XCTest
@testable import Networking

class NetworkingTests: XCTestCase {

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
    
    struct TestEndpoint: Endpoint {
        let url: URL? = URL(string: "https://www.mercadolibre.com.uy")
        let path = ""
        let method: HTTPMethod = .get
        var task: HTTPTask {
            return .requestParameters(bodyParameters: nil, urlParameters: nil)
        }
        var headers: HTTPHeaders?
    }
    
    func testURLSessionRouter() {
        let router = URLSessionRouter()
        let endpoint = TestEndpoint()
        let expect = expectation(description: "Server responds to request")
        router.request(endpoint) { data, response, error in
            if data != nil, error == nil {
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}
