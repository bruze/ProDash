//
//  Coordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import UIKit
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
