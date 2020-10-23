//
//  ProfileViewModel.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/23/20.
//

import Combine
import Model

final class ProfileViewModel {
    private var services: ServiceLocator?
    //MARK: Members
    var alias: String = ""
    var userLogged = CurrentValueSubject<Bool?, Never>(nil)
    //MARK: Setup
    init(services: ServiceLocator?) {
        self.services = services
        if services?.userManager.currentUser?.currentState == .logged {
            userLogged.value = true
        }
    }
    //MARK: Action
    func login() {
        guard let userManager = services?.userManager else { return }
        userManager.logUser(with: alias)
    }
}
