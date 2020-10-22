//
//  FavoritesController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/22/20.
//

import UIKit

final class FavoritesController: BaseViewController, ControllerType {
    //MARK: Members
    static let identifier = "Favorites"
    static let storyboardId = "Favorites"
    var coordinator: FavoritesCoordinator?
    private lazy var model = FavoritesViewModel(services: services, collection: favorites)
    //MARK: Outlets
    @IBOutlet weak var favorites: UICollectionView!
    private var favoritesDisplay = ProductsCollectionDisplay.list
    private var favoritesLayout: UICollectionViewFlowLayout? { favorites.collectionViewLayout as? UICollectionViewFlowLayout }
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favorites.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
        favorites.register(UINib(nibName: ProductsHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductsHeader.identifier)
        favoritesLayout?.sectionHeadersPinToVisibleBounds = true
        
        updateModel()
    }
    
    func updateModel() {
        model.fetch()
    }
}

extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        return .init(width: Int(screenSize.width) - 50, height: 100)
        
    }
}
