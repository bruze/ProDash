//
//  ViewController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import UIKit
import Logging

class BaseViewController: UIViewController, Describable {

    override func viewDidLoad() {
        super.viewDidLoad()

        Log.message("\(logDescription) did load", as: .info)
    }


}

