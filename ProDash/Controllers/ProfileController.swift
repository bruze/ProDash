//
//  ProfileController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/23/20.
//

import UIKit
import Combine

final class ProfileController: BaseViewController, ControllerType {
    //MARK: Members
    static let identifier = "Profile"
    static let storyboardId = "Profile"
    private lazy var model = ProfileViewModel(services: coordinator?.services)
    var coordinator: DashboardCoordinator?
    private lazy var aliasInputObserver = NotificationCenter.default
        .publisher(for: UITextField.textDidChangeNotification, object: alias)
    private lazy var loginEnabledSubscriber = Subscribers.Assign(object: login, keyPath: \.isEnabled)
    //MARK: Outlets
    @IBOutlet weak var alias: UITextField!
    @IBOutlet weak var login: RoundButton!
    @IBOutlet weak var logout: UIButton!
    /// Binding
    private var aliasObserver: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindModel()
    }

    private func bindModel() {
        /// Update model from 'alias' text field input
        aliasObserver = aliasInputObserver
            .compactMap({ ($0.object as? UITextField)?.text })
            .sink(receiveValue: {[weak self] value in
                    guard let self = self else { return }
                    self.model.alias = value })
        /// Enable 'login' when 'alias' has valid input
        aliasInputObserver
            .compactMap({ !(($0.object as? UITextField)?.text?.isEmpty ?? true) })
            .subscribe(loginEnabledSubscriber)
        model.userLogged.sink {[weak self] userLogged in
            guard let self = self, let userLogged = userLogged else { return }
            if userLogged {
                self.alias.isHidden = true
                self.login.isHidden = true
            }
        }.store(in: &cancellables)
    }
    //MARK: Action
    @IBAction func loginTap() {
        model.login()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutTap() {
        services?.userManager.logout()
        dismiss(animated: true, completion: nil)
    }
}
