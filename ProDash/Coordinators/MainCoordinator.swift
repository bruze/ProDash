//
//  MainCoordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/18/20.
//

import UIKit

extension Notification.Name {
    static let homeFlowExited = Notification.Name(rawValue: "homeFlowExited")
}

final class MainCoordinator: NSObject, Coordinator {
    let flowName = "Main"
    //MARK: Member
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var services: ServiceLocator? = DefaultServiceLocator()
    //MARK: Setup
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
        start()
    }
    //MARK: Action
    private func start() {
        /*let home = HomeCoordinator(navigationController: navigationController, services: services)
        childCoordinators.append(home)
        home.parentCoordinator = self*/
        services?.userManager.logUser(with: "")
        let dashboard = DashboardCoordinator(navigationController: navigationController, services: services)
        childCoordinators.append(dashboard)
        dashboard.parentCoordinator = self
        dashboard.start()
        navigationController.navigationBar.isHidden = false
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if let coordinated = fromViewController as? FlowStarter, let coordinator = coordinated.anyCoordinator as? Coordinator {
            childDidFinish(coordinator)
        }
    }
}
