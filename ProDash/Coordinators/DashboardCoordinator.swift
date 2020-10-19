//
//  DashboardCoordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import UIKit

final class DashboardCoordinator: NSObject, Coordinator {
    var flowName = "Dashboard"
    //MARK: Members
    var services: ServiceLocator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    weak var dashboardController: DashboardController?
    //MARK: Setup
    init(navigationController: UINavigationController, services: ServiceLocator?) {
        self.navigationController = navigationController
        self.services = services
        super.init()
        (navigationController.navigationBar as? NavigationBar)?.customDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(start), name: .homeFlowExited, object: nil)
    }
    //MARK: Action
    @objc private func start() {
        if let vc = DashboardController.create(parentCoordinator?.services) {
            dashboardController = vc
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    private func startSearch() {
        let search = SearchCoordinator(navigationController: navigationController, services: services)
        /// Home is a temporal flow, now Dashboard is the first child of Main
        search.parentCoordinator = self
        childCoordinators.append(search)
        search.start()
    }
    
    func contain(_ controller: UIViewController) {
        dashboardController?.contain(controller)
    }
}

extension DashboardCoordinator: NavigationBarDelegate {
    func sent(action: NavigationBarAction) {
        switch action {
        case .search:
            startSearch()
        case .favorites:
            break
        }
    }
}
