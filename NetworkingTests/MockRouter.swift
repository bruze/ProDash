//
//  MockRouter.swift
//  NetworkingTests
//
//  Created by Bruno Garelli on 10/22/20.
//

import Foundation
@testable import Networking
public final class MockRouter: NetworkRouter {
    public func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        
    }
    
    public func fetch(_ route: Endpoint, completion: @escaping NetworkRouterModelCompletion) {
        
    }
    
    public func cancel() {
        
    }
    
    
}
