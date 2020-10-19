//
//  NavigationBar.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import UIKit

enum NavigationBarAction {
    case search
    case favorites
}

protocol NavigationBarDelegate {
    func sent(action: NavigationBarAction)
}

final class NavigationBar: UINavigationBar {
    //MARK: Members
    var customDelegate: NavigationBarDelegate?
    //MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    //MARK: Action
    @IBAction func search() {
        customDelegate?.sent(action: .search)
    }

    @IBAction func favorites() {
        customDelegate?.sent(action: .favorites)
    }
}
