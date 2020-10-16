//
//  Describable.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import Foundation

protocol Describable: class {
    var logDescription: String { get }
}

extension Describable {
    var logDescription: String {
        return "\(self)".textBetween((".", ":"))
    }
}
