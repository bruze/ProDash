//
//  SearchController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/18/20.
//

import Model
import UIKit
import Combine

final class SearchController: BaseViewController, ControllerType, FlowStarter {
    static let identifier = "Search"
    static let storyboardId = "Search"
    //MARK: Outlets
    @IBOutlet weak var products: UICollectionView!
    //MARK: Members
    var anyCoordinator: Any? { coordinator }
    var coordinator: SearchCoordinator?
    private lazy var model = SearchViewModel(services: coordinator?.services)
    
}
