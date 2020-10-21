//
//  ProductCell.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/20/20.
//

import UIKit
import Model
import Kingfisher

final class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    
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

}
