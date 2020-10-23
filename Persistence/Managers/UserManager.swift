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
    func logout()
    func save(user: User, setCurrent: Bool)
    func addFavourite(_ product: Product)
    func removeFavourite(_ product: Product)
    func addViewed(_ product: Product)
    func isFavourite(_ product: Product) -> Bool
}
