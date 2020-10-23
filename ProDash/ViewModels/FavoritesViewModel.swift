//
//  FavoritesViewModel.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/22/20.
//

import Combine
import Model
import UIKit

final class FavoritesViewModel {
    //MARK: Members
    private var services: ServiceLocator?
    private var dataSource: DataSource!
    private var products = [Product]()
    var productsHeaderAction = CurrentValueSubject<ProductsHeaderAction?, Never>(nil)
    var selectedProduct = CurrentValueSubject<Product?, Never>(nil)
    //MARK: Setup
    init(services: ServiceLocator?, collection: UICollectionView) {
        self.services = services
        self.dataSource = DataSource(collectionView: collection, cellProvider: { collection, index, product -> UICollectionViewCell? in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: index) as? ProductCell
            cell?.product = product
            cell?.delegate = self
            cell?.favouriteButton.isHidden = true
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
    
    func fetch() {
        products.removeAll()
        if let favorites = services?.userManager.currentUser?.favorites {
            products.append(contentsOf: Array(favorites))
            applySnapshot()
        }
    }
    
    //MARK: Action
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FavoritesViewModel: ProductsHeaderDelegate {
    func sent(action: ProductsHeaderAction) {
        productsHeaderAction.value = action
    }
}

extension FavoritesViewModel: ProductCellDelegate {
    func isFavourite(_ product: Product) -> Bool {
        //services?.userManager.isFavourite(product) ?? false
        true
    }
    
    func addedFavourite(_ product: Product) {
        //services?.userManager.addFavourite(product)
    }
    
    func removedFavourite(_ product: Product) {
        //services?.userManager.removeFavourite(product)
    }
    
    func didSelect(_ product: Product) {
        selectedProduct.value = product
    }
}
