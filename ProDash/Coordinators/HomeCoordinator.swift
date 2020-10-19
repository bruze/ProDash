//
//  HomeCoordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import UIKit
import Utilities
import Persistence
import Logging

final class HomeCoordinator: NSObject, Coordinator {
    let flowName = "Home"
    //MARK: Member
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    var services: ServiceLocator?
    //MARK: Setup
    init(navigationController: UINavigationController, services: ServiceLocator?) {
        self.navigationController = navigationController
        self.services = services
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(userDidLog), name: .userLogged, object: nil)
        start()
    }
    //MARK: Action
    private func start() {
        if let vc = HomeController.create(services) {
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    private func startDashboard() {
        /// Home is a temporal flow, now Dashboard is the first child of Main
        parentCoordinator?.childDidFinish(self)
        let dashboard = DashboardCoordinator(navigationController: navigationController, services: services)
        dashboard.parentCoordinator = parentCoordinator
        parentCoordinator?.childCoordinators.append(dashboard)
        NotificationCenter.default.post(name: .homeFlowExited, object: nil)
        /// Show navigation bar as it gives access to Search and Favorites flows
        navigationController.navigationBar.isHidden = false
    }
    
    @objc func userDidLog() {
        guard let user = services?.userManager.currentUser else { return }
        if user.currentState == .guest {
            user.setState(transitions: [])
        }
        startDashboard()
    }
}


