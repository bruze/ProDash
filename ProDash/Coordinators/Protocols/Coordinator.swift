//
//  Coordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import UIKit
protocol Coordinator: class {
    var flowName: String { get }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var services: ServiceLocator? { get }

    //func start()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    var flowStarter: FlowStarter.Type? { nil }
    
    private func start() {
        /*if let flowStarter = flowStarter {
            switch flowStarter {
            case let coordinator where coordinator is Coordinator.Type:
                childCoordinators.append(coordinator.init() as! Coordinator)
                break
            case let controler where controler is ControllerType.Type:
                break
            default:
                break
            }
        }*/
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        if let flow = child?.flowName {
            services?.logger.message("Exited \(flow) flow", as: .info)
        }
        if let lastFlowHead = navigationController.viewControllers.lastIndex(where: { $0 is FlowStarter }) {
            navigationController.viewControllers.removeLast(navigationController.viewControllers.count - lastFlowHead)
        }
    }
}
