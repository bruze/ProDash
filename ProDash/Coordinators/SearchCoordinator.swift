//
//  SearchCoordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/18/20.
//

import UIKit

final class SearchCoordinator: NSObject, Coordinator {
    //MARK: Members
    let flowName = "Search"
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var services: ServiceLocator?
    var parentCoordinator: DashboardCoordinator?
    //MARK: Setup
    init(navigationController: UINavigationController, services: ServiceLocator?) {
        self.navigationController = navigationController
        self.services = services
        super.init()
        //start()
    }
    //MARK: Action
    func start() {
        if let vc = SearchController.create(services) {
            vc.coordinator = self
            parentCoordinator?.contain(vc)
        }
    }
    
    
}