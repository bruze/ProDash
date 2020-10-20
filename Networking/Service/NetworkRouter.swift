//
//  NetworkRouter.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//
/**
    This interface is designed to be accomplished by objects handling http tasks flows
     from the creation of the request to the processing of results and delegating
 */
import Model

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
public typealias NetworkRouterModelCompletion = (_ model: [Model]?, _ pagination: ProductPagination?, _ error: Error?) -> ()
public protocol NetworkRouter: class {
    //associatedtype EndpointType: Endpoint
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func fetch(_ route: Endpoint, completion: @escaping NetworkRouterModelCompletion)
    func cancel()
}
