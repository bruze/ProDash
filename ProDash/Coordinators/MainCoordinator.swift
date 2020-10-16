//
//  MainCoordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        if let vc = HomeController.create() {
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        navigationController.popToRootViewController(animated: true)
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

        /*if let amountViewController = fromViewController as? AmountInputController {
            childDidFinish(amountViewController.coordinator)
        } else if let historyController = fromViewController as? HistoryController {
            childDidFinish(historyController.coordinator)
        }*/
    }
}
