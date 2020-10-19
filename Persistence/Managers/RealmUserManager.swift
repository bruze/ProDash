//
//  DefaultUserManager.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import Model

public extension Notification.Name {
    static let userLogged = Notification.Name(rawValue: "userLogged")
}

public final class RealmUserManager: UserManager {
    public var currentUser: User?
    
    public init() {}
    
    public func logUser(with alias: String) {
        let repository = RealmRepository()
        currentUser = {
            guard !alias.isEmpty else {
                /// New guest User
                return User()
            }
            if let registered: User = repository.get(alias, User.self) {
                return registered
            } else {
                let newUser = User()
                newUser.alias = alias
                newUser.set(state: .logged)
                repository.set(newUser)
                return newUser
            }
        }()
        NotificationCenter.default.post(name: .userLogged, object: nil)
    }
    
    public func save(user: User) {
        RealmRepository().set(user)
    }
}