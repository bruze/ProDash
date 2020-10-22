//
//  DashboardCoordinator.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import UIKit

final class DashboardCoordinator: NSObject, Coordinator {
    //MARK: Members
    var flowName = "Dashboard"
    var services: ServiceLocator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    weak var dashboardController: DashboardController? /// Handy to send controllers-level commands as it's a bridge between flows
    /// Child coordinators/ flows; this avoids duplicating childs/ controllers
    private var search: SearchCoordinator? {
        return childCoordinators.filter({ $0 is SearchCoordinator }).first as? SearchCoordinator
    }
    private var favorites: FavoritesCoordinator? {
        return childCoordinators.filter({ $0 is FavoritesCoordinator }).first as? FavoritesCoordinator
    }
    //MARK: Setup
    init(navigationController: UINavigationController, services: ServiceLocator?) {
        self.navigationController = navigationController
        self.services = services
        super.init()
        (navigationController.navigationBar as? NavigationBar)?.customDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(start), name: .homeFlowExited, object: nil)
    }
    //MARK: Action
    @objc func start() {
        if let vc = DashboardController.create(parentCoordinator?.services) {
            dashboardController = vc
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    private func startSearch() {
        let search = SearchCoordinator(navigationController: navigationController, services: services)
        search.parentCoordinator = self
        childCoordinators.append(search)
        search.start()
    }
    
    private func startFavorites() {
        let favorites = FavoritesCoordinator(navigationController: navigationController, services: services)
        favorites.parentCoordinator = self
        childCoordinators.append(favorites)
        favorites.start()
    }
    
    func contain(_ controller: UIViewController) {
        dashboardController?.contain(controller)
    }
}

extension DashboardCoordinator: NavigationBarDelegate {
    func sent(action: NavigationBarAction) {
        switch action {
        case .search:
            search == nil ? startSearch(): dashboardController?.show(SearchController.self)
        case .favorites:
            favorites == nil ? startFavorites(): dashboardController?.show(FavoritesController.self)
        case .query(let text):
            if let searchController = dashboardController?.getContainedController(SearchController.self) {
                searchController.query(text)
            }
        case .dashboard:
            dashboardController?.hideAllContained()
        case .cleanQuery:
            if let searchController = dashboardController?.getContainedController(SearchController.self) {
                searchController.cleanQuery()
            }
        }
    }
}
