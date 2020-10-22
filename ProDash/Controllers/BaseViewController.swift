//
//  ViewController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import UIKit
import Logging

class BaseViewController: UIViewController, Describable {
    var services: ServiceLocator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        services?.logger.message("\(logDescription) did load", as: .info)
    }

    func presentMessage(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}

