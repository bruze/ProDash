//
//  ParameterEncoding.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

