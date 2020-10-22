//
//  SearchViewModel.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/20/20.
//

import Combine
import Model
import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<Int, Product>
typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Product>

final class SearchViewModel {
    //MARK: Members
    private var services: ServiceLocator?
    private var productsEndpoint = SearchProductsEndpoint()
    private var pagination = ProductPagination()
    private var dataSource: DataSource!
    /*private*/ var products = [Product]()
    var fetchingEnded = CurrentValueSubject<Void?, Never>(nil)
    var productsHeaderAction = CurrentValueSubject<ProductsHeaderAction?, Never>(nil)
    var selectedProduct = CurrentValueSubject<Product?, Never>(nil)
    //MARK: Setup
    init(services: ServiceLocator?, collection: UICollectionView) {
        self.services = services
        self.dataSource = DataSource(collectionView: collection, cellProvider: { collection, index, product -> UICollectionViewCell? in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: index) as? ProductCell
            cell?.product = product
            cell?.delegate = self
            return cell
        })
        self.dataSource.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath in
            guard let self = self, kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProductsHeader.identifier,
                for: indexPath) as? ProductsHeader
            header?.delegate = self
            return header
        }
    }
    //MARK: Action
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetch() {
        services?.networkRouter.fetch(productsEndpoint, completion: {[weak self] objects, paginationInfo, error in
            defer { self?.fetchingEnded.value = () }
            guard let self = self else { return }
            if let pages = paginationInfo { self.pagination = pages }
            if let products = objects as? [Product] {
                self.products.append(contentsOf: products)
                DispatchQueue.main.async {
                    self.applySnapshot()
                }
            }
        })
    }
    
    func update(query: String) {
        products.removeAll()
        productsEndpoint.query = query
        fetch()
    }
    
    func canFetchMoreProducts() -> Bool {
        return pagination.offset + pagination.limit < min(pagination.total, .maxFetchedProductsWithoutToken)
    }
    
    func fetchMoreProducts() {
        productsEndpoint.offset += pagination.limit
        fetch()
    }
    
    func cleanQuery() {
        productsEndpoint.query = ""
        products.removeAll()
        pagination = ProductPagination()
        applySnapshot()
    }
}

extension SearchViewModel: ProductsHeaderDelegate {
    func sent(action: ProductsHeaderAction) {
        productsHeaderAction.value = action
    }
}

extension SearchViewModel: ProductCellDelegate {
    func didSelect(_ product: Product) {
        selectedProduct.value = product
    }
}
