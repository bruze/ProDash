//
//  ProductCell.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/20/20.
//

import UIKit
import Model
import Kingfisher

protocol ProductCellDelegate {
    func didSelect(_ product: Product)
    func addedFavourite(_ product: Product)
    func removedFavourite(_ product: Product)
    func isFavourite(_ product: Product) -> Bool
}

final class ProductCell: UICollectionViewCell {
    //MARK: Members
    private let notFavouriteImage = UIImage(systemName: "star")
    private let favouriteImage = UIImage(systemName: "star.fill")
    static let identifier = "ProductCell"
    private var isFavourite = false
    var delegate: ProductCellDelegate?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    var product: Product? {
        didSet {
            guard let product = product else { return }
            title.text = product.title
            thumb.kf.setImage(with: URL(string: product.thumbnail))
        }
    }
    //MARK: Setup
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        guard let product = product else { return }
        isFavourite = delegate?.isFavourite(product) ?? false
        favouriteButton.setImage(isFavourite ? favouriteImage: notFavouriteImage, for: .normal)
    }
    //MARK: Action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let product = product else { return }
        delegate?.didSelect(product)
    }

    @IBAction func toggleFavourite(_ sender: UIButton) {
        isFavourite = !isFavourite
        sender.setImage(isFavourite ? favouriteImage: notFavouriteImage, for: .normal)
        guard let product = product else { return }
        if isFavourite { delegate?.addedFavourite(product) } else { delegate?.removedFavourite(product) }
    }
}
