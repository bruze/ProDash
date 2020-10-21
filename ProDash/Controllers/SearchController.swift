//
//  SearchController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/18/20.
//

import Model
import UIKit
import Combine
import Networking

final class SearchController: BaseViewController, ControllerType, FlowStarter {
    enum ActivityIndicatorPosition {
        case bottom
        case middle
    }
    enum ProductsCollectionDisplay {
        case grid
        case list
    }
    
    static let identifier = "Search"
    static let storyboardId = "Search"
    //MARK: Outlets
    @IBOutlet weak var products: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorAtBottom: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorAtMiddle: NSLayoutConstraint!
    //MARK: Members
    var anyCoordinator: Any? { coordinator }
    var coordinator: SearchCoordinator?
    private lazy var model = SearchViewModel(services: coordinator?.services, collection: products)
    private var cancellables = Set<AnyCancellable>()
    private var productsDisplay = ProductsCollectionDisplay.list
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        products.contentInset = .init(top: 0, left: 0, bottom: 15, right: 0)
        products.delegate = self
        products.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
        products.register(UINib(nibName: ProductsHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductsHeader.identifier)
        bindModel()
    }
    
    private func bindModel() {
        model.fetchingEnded.sink {[weak self] value in
            guard let _ = value else { return }
            self?.hideActivityIndicator()
        }.store(in: &cancellables)
        model.productsHeaderAction.sink {[weak self] action in
            guard let self = self, let action = action else { return }
            switch action {
            case .showAsGrid where self.productsDisplay != .grid:
                self.productsDisplay = .grid
                self.model.applySnapshot()
            case .showAsList where self.productsDisplay != .list:
                self.productsDisplay = .list
                self.model.applySnapshot()
            default: break
            }
        }.store(in: &cancellables)
    }
    
    //MARK: Action
    func query(_ text: String) {
        setActivityIndicator(at: .middle)
        showActivityIndicator()
        model.update(query: text)
    }
    
    @objc private func queryNextPage() {
        if model.canFetchMoreProducts() {
            setActivityIndicator(at: .bottom)
            showActivityIndicator()
            model.fetchMoreProducts()
        }
    }
    
    func cleanQuery() {
        model.cleanQuery()
    }
    //MARK: Update
    private func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setActivityIndicator(at position: ActivityIndicatorPosition) {
        switch position {
        case .bottom:
            activityIndicatorAtMiddle.isActive = false
            activityIndicatorAtBottom.isActive = true
        case .middle:
            activityIndicatorAtMiddle.isActive = true
            activityIndicatorAtBottom.isActive = false
        }
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        switch productsDisplay {
        case .grid:
            return .init(width: Int(screenSize.width)/2 - 10, height: 100)
        case .list:
            return .init(width: Int(screenSize.width) - 10, height: 100)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if products.contentOffset.y + products.frame.height >= products.contentSize.height + .verticalDragThresholdToRefreshProducts {
            queryNextPage()
        }
    }
}
