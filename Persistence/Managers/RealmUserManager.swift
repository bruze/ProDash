//
//  DefaultUserManager.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import Model
import RealmSwift

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
                registered.set(state: .logged)
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
    
    public func logout() {
        currentUser = User()
    }
    
    public func save(user: User, setCurrent: Bool = false) {
        if !user.alias.isEmpty {
            RealmRepository().set(user)
        }
        if setCurrent { currentUser = user }
    }
    
    public func addFavourite(_ product: Product) {
        guard let user = currentUser else { return }
        let realm = try! Realm()
        //realm.beginWrite()
        try! realm.write {
            user.favorites.append(product)
        }
        
        //try! realm.commitWrite()
        //save(user: user)
    }
    
    public func removeFavourite(_ product: Product) {
        guard let user = currentUser else { return }
        if let index = user.favorites.index(of: product) {
            let realm = try! Realm()
            //realm.beginWrite()
            try! realm.write {
                user.favorites.remove(at: index)
            }
            
            //try! realm.commitWrite()
            //save(user: user)
        }
    }
    
    public func addViewed(_ product: Product) {
        guard let user = currentUser else { return }
        user.lastViewed.append(product)
        save(user: user)
    }
    
    public func isFavourite(_ product: Product) -> Bool {
        guard let user = currentUser else { return false }
        let ids = Array(user.favorites).map({ $0.productId })
        //let found = user.favorites.filter({ $0.productId == product.productId }).first
        return ids.contains(product.productId)
    }
}
