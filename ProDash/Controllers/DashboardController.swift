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
        container.addSubview(controller.view)
    }
}
