//
//  RealmRepository.swift
//  Persistence
//
//  Created by Bruno Garelli on 10/16/20.
//

import Model
import RealmSwift

public final class RealmRepository: Repository {
    
    public init() {}
    
    public func set<Entity>(_ model: Entity) {
        guard let object = model as? Object else { return }
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        } catch {
            
        }
    }
    
    public func get<Entity>(_ key: String, _ type: Entity.Type) -> Entity? where Entity: Object {
        do {
            let realm = try Realm()
            if let object = realm.object(ofType: type, forPrimaryKey: key) {
                return object
            }
            return nil
        } catch {
            return nil
        }
    }
    
    
}
