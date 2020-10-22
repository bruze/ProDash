//
//  RealmRepository.swift
//  Persistence
//
//  Created by Bruno Garelli on 10/16/20.
//

import Model
import RealmSwift

public final class RealmRepository: Repository {
    
    public init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config

        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let _ = try! Realm()
    }
    
    public func set<Entity>(_ model: Entity) {
        guard let object = model as? Object else { return }
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        } catch { error
            print()
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
