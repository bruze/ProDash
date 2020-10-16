//
//  Coordinable.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

protocol Coordinable {
    associatedtype CoordinatorType = Coordinator
    var coordinator: CoordinatorType? { get set }
}
