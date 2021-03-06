//
//  DefaultServiceLocator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import Persistence
import Logging
import Utilities
import Model
import Networking

struct DefaultServiceLocator: ServiceLocator {
    var logger: LoggingService = Log()
    var userManager: UserManager = RealmUserManager()
    var networkRouter: NetworkRouter = URLSessionRouter()
}
