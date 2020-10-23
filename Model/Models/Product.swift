//
//  Product.swift
//  Model
//
//  Created by Bruno Garelli on 10/19/20.
//

import RealmSwift

public class Product: Object, Model {
    @objc dynamic public var id: String = ""
    @objc dynamic public var productId: String = ""
    @objc dynamic public var title: String = UUID().uuidString
    @objc dynamic public var price: Double = 0.0
    @objc dynamic public var currency_id: String = ""
    @objc dynamic public var thumbnail: String = ""
    public let attributes = List<ProductAttribute>()
    
    /*public override class func primaryKey() -> String? {
        return "title"
    }*/
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let product = object as? Product else { return false }
        guard !id.isEmpty else { return false }
        return productId == product.productId
    }
}

public class ProductAttribute: Object, Model {
    @objc public var name: String = ""
    @objc public var value_name: String? = ""
}
