//
//  Log.swift
//  Logging
//
//  Created by Bruno Garelli on 10/15/20.
//

import os

public struct Log {
    public enum LoggingLevel {
        case debug
        case info
        case verbose
        case warning
        case error
    }

    public static func message(_ message: String, as level: LoggingLevel) {
        let log = Logger()
        switch level {
        case .debug:
            #if DEBUG
            log.debug("🔍DEBUG: \(message)")
            #endif
        case .info:
            log.info("ℹ️INFO: \(message)")
        case .verbose:
            log.notice("⚠️NOTICE: \(message)")
        case .warning:
            log.warning("❌ERROR: \(message)")
        case .error:
            log.error("⛔️FAULT: \(message)")
        }
    }
}
