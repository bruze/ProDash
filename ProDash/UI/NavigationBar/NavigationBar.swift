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
    case dashboard
    case query(text: String)
    case cleanQuery
    case profile
}

protocol NavigationBarDelegate {
    func sent(action: NavigationBarAction)
}

final class NavigationBar: UINavigationBar {
    //MARK: Outlets
    @IBOutlet private weak var lens: UIButton!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var favoritesButton: UIButton!
    @IBOutlet private weak var home: UIButton!
    @IBOutlet private weak var homeRight: UIButton!
    @IBOutlet weak var profile: UIButton!
    //MARK: Members
    var customDelegate: NavigationBarDelegate?
    //MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setup()
    }
    
    private func setup() {
        searchBar.searchTextField.delegate = self
    }
    //MARK: Action
    @IBAction func search() {
        lens.isHidden = true
        home.isHidden = false
        homeRight.isHidden = true
        favoritesButton.isHidden = false
        searchBar.isHidden = false
        profile.isHidden = true
        searchBar.becomeFirstResponder()
        customDelegate?.sent(action: .search)
    }

    @IBAction func favorites() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        home.isHidden = true
        lens.isHidden = false
        favoritesButton.isHidden = true
        homeRight.isHidden = false
        profile.isHidden = false
        customDelegate?.sent(action: .cleanQuery)
        customDelegate?.sent(action: .favorites)
    }
    
    @IBAction func dashboard() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        home.isHidden = true
        lens.isHidden = false
        homeRight.isHidden = true
        favoritesButton.isHidden = false
        profile.isHidden = false
        customDelegate?.sent(action: .cleanQuery)
        customDelegate?.sent(action: .dashboard)
    }
    
    @IBAction func manageProfile() {
        customDelegate?.sent(action: .profile)
    }
}

extension NavigationBar: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        customDelegate?.sent(action: .cleanQuery)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textFieldText = textField.text  {
            let finalText = (textFieldText as NSString).replacingCharacters(in: range, with: string)
            if finalText.count > 2 {
                customDelegate?.sent(action: .query(text: finalText))
            } else {
                customDelegate?.sent(action: .cleanQuery)
            }
        }
        return true
    }
}
