//
//  Product.swift
//  Model
//
//  Created by Bruno Garelli on 10/19/20.
//

import RealmSwift

public class Product: Object, Model {
    @objc public var id: String = ""
    @objc public var title: String = ""
    @objc public var price: Double = 0.0
    @objc public var currency_id: String = ""
    @objc public var thumbnail: String = ""
}
