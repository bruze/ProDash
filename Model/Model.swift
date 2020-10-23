//
//  Model.swift
//  Model
//
//  Created by Bruno Garelli on 10/16/20.
//

import ObjectiveC

public protocol Model: NSObject {
    static func parsedFrom(parameters: [String: Any]) -> Self
}

public extension Model {
    static func parsedFrom(parameters: [String: Any]) -> Self {
        let instance = Self()
        let mirror = Mirror.init(reflecting: instance)
        mirror.children.forEach({
            if let label = $0.label, let value = parameters[label] {
                if label == "id" {
                    instance.setValue(value, forKey: "productId")
                } else {
                    instance.setValue(value, forKey: label)
                }
            }
        })
        return instance
    }
}
