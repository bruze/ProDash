//
//  NetworkError.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//

public enum NetworkError: String, Error {
    case networkOffline = "Network Offline"
    case badRequest = "Bad request"
    case authenticationError = "Authentication error"
    case outdated = "Outdated"
    case failed = "Failed"
    case serverError = "Server Error"
    case encodingFailed = "Encoding failed"
    case missingURL = "Missing URL"
    case SSLError = "SSL Error" /// This is a strange -1005 code error probably caused for a server config which causes a request to work on the second try sometimes
    
    public var localizedDescription: String {
        return rawValue
    }
}

