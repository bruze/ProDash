//
//  Endpoint.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//

import Model
public protocol Endpoint {
    var fetchingModel: Model.Type? { get }
    var url: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

public extension Endpoint {
    var url: URL? { URL(string: Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "") }
    var fetchingModel: Model.Type? { nil }
}
