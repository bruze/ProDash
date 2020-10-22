//
//  ControllerType.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import UIKit

protocol ControllerType: class, Coordinable {
    static var identifier: String { get }
    static var storyboardId: String { get }
    static func create(_ services: ServiceLocator?) -> Self?
}

extension ControllerType {
    static func create(_ services: ServiceLocator? = nil) -> Self? {
        let storyboard = UIStoryboard(name: Self.storyboardId, bundle: nil)
        let viewController = identifier.isEmpty ? storyboard.instantiateInitialViewController(): storyboard.instantiateViewController(withIdentifier: identifier)
        viewController?.modalPresentationStyle = .fullScreen
        (viewController as? BaseViewController)?.services = services
        if let controller = (viewController as? Self) ?? (viewController as? UINavigationController)?.children.first as? Self {
            return controller
        }
        return nil
    }
}
