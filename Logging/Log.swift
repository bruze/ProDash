//
//  Log.swift
//  Logging
//
//  Created by Bruno Garelli on 10/15/20.
//

import os

public struct Log: LoggingService {
    private var _logger = Logger()
    public init() {}
    
    public func message(_ message: String, as level: LoggingLevel) {
        switch level {
        case .debug:
            #if DEBUG
            _logger.debug("🔍DEBUG: \(message)")
            #endif
        case .info:
            _logger.info("ℹ️INFO: \(message)")
        case .verbose:
            _logger.notice("⚠️NOTICE: \(message)")
        case .warning:
            _logger.warning("❌ERROR: \(message)")
        case .error:
            _logger.error("⛔️FAULT: \(message)")
        }
    }
}
