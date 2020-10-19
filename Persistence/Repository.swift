//
//  Repository.swift
//  Persistence
//
//  Created by Bruno Garelli on 10/16/20.
//

import Model

public protocol Repository {
    func set<Entity>(_ model: Entity)
    func get<Entity>(_ key: String, _ type: Entity.Type) -> Entity?
}

extension Repository {
    public func get<Entity>(_ key: String, _ type: Entity.Type) -> Entity? { nil }
}
