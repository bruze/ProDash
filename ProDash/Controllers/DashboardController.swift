//
//  DashboardController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import Model
import UIKit
import Combine
/**
    It's a controller's container that engages and handles the different
    flows in the app. Thus it's not asscoiated view model
 */
final class DashboardController: BaseViewController, ControllerType {
    //MARK: Members
    static let identifier = "Dashboard"
    static let storyboardId = "Home"
    var coordinator: DashboardCoordinator?
    //MARK: Outlet
    @IBOutlet weak var container: UIView!
    //MARK: API
    func contain(_ controller: UIViewController) {
        addChild(controller)
        container.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func getContainedController<T>(_ type: T.Type) -> T? where T: ControllerType {
        return children.filter({ $0 is T }).first as? T
    }
    
    func show<T>(_ type: T.Type) where T: ControllerType {
        hideAllContained()
        let controller = (getContainedController(type) as? UIViewController)
        if let favorites = controller as? FavoritesController {
            favorites.updateModel()
        }
        controller?.view?.isHidden = false
    }
    
    func hideAllContained() {
        children.map({ $0.view }).forEach({ $0?.isHidden = true })
    }
}
