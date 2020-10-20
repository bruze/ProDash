//
//  ServiceLocator.swift
//  Utilities
//
//  Created by Bruno Garelli on 10/17/20.
//

import Foundation
import Persistence
import Logging
import Utilities
import Model
import Networking

public protocol ServiceLocator {
    var logger: LoggingService { get }
    var userManager: UserManager { get }
    var networkRouter: NetworkRouter { get }
}
