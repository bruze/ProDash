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

enum ProductsCollectionDisplay {
    case grid
    case list
}

final class SearchController: BaseViewController, ControllerType, FlowStarter {
    enum ActivityIndicatorPosition {
        case bottom
        case middle
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
    private var productsLayout: UICollectionViewFlowLayout? { products.collectionViewLayout as? UICollectionViewFlowLayout }
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        products.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        products.delegate = self
        products.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
        products.register(UINib(nibName: ProductsHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductsHeader.identifier)
        productsLayout?.sectionHeadersPinToVisibleBounds = true
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
        model.selectedProduct.sink {[weak self] product in
            guard let self = self, let product = product else { return }
            self.coordinator?.showDetail(for: product)
        }.store(in: &cancellables)
        model.error.sink {[weak self] error in
            guard let self = self, let error = error else { return }
            DispatchQueue.main.async {
                switch error {
                case NetworkError.networkOffline:
                    self.presentMessage("Error", "Lo sentimos, parece que tu conexión no está disponible. Por favor chequea que tengas acceso a internet e intenta nuevamente. Gracias")
                default:
                    self.presentMessage("Error", "Lo sentimos, parece que hubo un error al procesar tu solicitud; por favor intenta nuevamente. Gracias")
                }
            }
        }.store(in: &cancellables)
    }
    
    //MARK: Action
    func query(_ text: String) {
        products.isHidden = false
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
        products.isHidden = true
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        productsLayout?.invalidateLayout()
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
