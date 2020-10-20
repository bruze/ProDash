//
//  UserManager.swift
//  Utilities
//
//  Created by Bruno Garelli on 10/17/20.
//

import Foundation
import Model

public protocol UserManager: class {
    var currentUser: User? { get }
    
    func logUser(with alias: String)
    func save(user: User, setCurrent: Bool)
    func addFavorite(_ product: Product)
    func addViewed(_ product: Product)
}
