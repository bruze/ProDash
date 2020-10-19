//
//  HomeController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/15/20.
//

import Model
import UIKit
import Combine

final class HomeController: BaseViewController, ControllerType, FlowStarter {
    //MARK: Members
    weak var coordinator: HomeCoordinator?
    private lazy var model = HomeViewModel(services: coordinator?.services)
    var anyCoordinator: Any? { coordinator }
    static let storyboardId = "Home"
    static let identifier = "Home"
    private lazy var aliasInputObserver = NotificationCenter.default
        .publisher(for: UITextField.textDidChangeNotification, object: alias)
    private lazy var loginEnabledSubscriber = Subscribers.Assign(object: login, keyPath: \.isEnabled)
    //private lazy var loginTapObserver = UIButton.Publisher<Base>
    //MARK: Outlets
    @IBOutlet weak var alias: UITextField!
    @IBOutlet weak var login: RoundButton!
    @IBOutlet weak var guest: RoundButton!
    /// Binding
    private var aliasObserver: AnyCancellable?
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
        
    }
    //MARK: Action
    @IBAction func loginTap() {
        model.login()
    }
    
    @IBAction func guestTap() {
        model.login()
    }
}
