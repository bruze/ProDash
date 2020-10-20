//
//  NetworkError.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//

public enum NetworkError: String, Error {
    case badRequest = "Bad request"
    case authenticationError = "Authentication error"
    case outdated = "Outdated"
    case failed = "Failed"
    case encodingFailed = "Encoding failed"
    case missingURL = "Missing URL"
    
    public var localizedDescription: String {
        return rawValue
    }
}

