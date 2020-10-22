//
//  FavoritesCoordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/22/20.
//

import UIKit

final class FavoritesCoordinator: NSObject, Coordinator {
    //MARK: Members
    let flowName = "Favorites"
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var services: ServiceLocator?
    weak var parentCoordinator: DashboardCoordinator?
    //MARK: Setup
    init(navigationController: UINavigationController, services: ServiceLocator?) {
        self.navigationController = navigationController
        self.services = services
        super.init()
    }
    
    func start() {
        if let vc = FavoritesController.create(services) {
            vc.coordinator = self
            parentCoordinator?.contain(vc)
        }
    }
}
