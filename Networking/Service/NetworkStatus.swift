//
//  NetworkStatus.swift
//  Networking
//
//  Created by Bruno Garelli on 10/22/20.
//

import Network
import Logging

public extension Notification.Name {
    static let networkRestored = Notification.Name(rawValue: "networkRestored")
    static let networkLost = Notification.Name(rawValue: "networkLost")
}

final class NetworkStatus {
    private var monitor = NWPathMonitor()
    private let logger = Log()
    
    init() {
        monitor.start(queue: .global()) // Deliver on background
        
        monitor.pathUpdateHandler = {[weak self] path in
            /// Online
            if path.status == .satisfied {
                self?.logger.message("Network connection available", as: .info)
                NotificationCenter.default.post(name: .networkRestored, object: nil)
            } else {
                /// Offline
                self?.logger.message("Network connection unavailable", as: .warning)
                NotificationCenter.default.post(name: .networkLost, object: nil)
            }
        }
    }
    
}
