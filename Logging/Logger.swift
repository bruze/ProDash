//
//  Logger.swift
//  Logging
//
//  Created by Bruno Garelli on 10/17/20.
//

import Foundation

public enum LoggingLevel {
    case debug
    case info
    case verbose
    case warning
    case error
}

public protocol LoggingService {
    func message(_ message: String, as level: LoggingLevel)
}
