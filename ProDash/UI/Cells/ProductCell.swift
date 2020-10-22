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
}

final class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    
    var delegate: ProductCellDelegate?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    var product: Product? {
        didSet {
            guard let product = product else { return }
            title.text = product.title
            thumb.kf.setImage(with: URL(string: product.thumbnail))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let product = product else { return }
        delegate?.didSelect(product)
    }

}
