//
//  ProductPagination.swift
//  Model
//
//  Created by Bruno Garelli on 10/20/20.
//

import Foundation

public class ProductPagination: NSObject, Model {
    @objc public var total = 0
    @objc public var primary_results = 0
    @objc public var offset = 0
    @objc public var limit = 0
}
