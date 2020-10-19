//
//  HomeViewModel.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/16/20.
//

import Combine
import Model

final class HomeViewModel {
    private var services: ServiceLocator?
    //MARK: Members
    var alias: String = ""
    //MARK: Setup
    init(services: ServiceLocator?) {
        self.services = services
    }
    //MARK: Action
    func login() {
        guard let userManager = services?.userManager else { return }
        userManager.logUser(with: alias)
    }
}
