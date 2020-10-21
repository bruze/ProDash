//
//  DashboardController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import Model
import UIKit
import Combine

final class DashboardController: BaseViewController, ControllerType {
    @IBOutlet weak var container: UIView!
    static let identifier = "Dashboard"
    static let storyboardId = "Home"
    
    var coordinator: DashboardCoordinator?
    
    func contain(_ controller: UIViewController) {
        addChild(controller)
        container.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func getContainedController<T>(_ type: T.Type) -> T? where T: ControllerType {
        return children.filter({ $0 is T }).first as? T
    }
    
    func show<T>(_ type: T.Type) where T: ControllerType {
        (getContainedController(type) as? UIViewController)?.view?.isHidden = false
    }
    
    func hideAllContained() {
        children.map({ $0.view }).forEach({ $0?.isHidden = true })
    }
}
