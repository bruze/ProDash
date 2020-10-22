//
//  ProductDetailController.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/21/20.
//

import UIKit
import Model
import Kingfisher

final class ProductDetailController: BaseViewController, ControllerType {
    static let identifier = "ProductDetail"
    static var storyboardId = "Search"
    //MARK: Members
    var coordinator: SearchCoordinator?
    var product: Product? {
        didSet {
            guard let product = product else { return }
            thumb.kf.setImage(with: URL(string: product.thumbnail))
            productTitle.text = product.title
            total.text = product.price.currencyFormat(product.currency_id)
            for attribute in product.attributes {
                guard let value = attribute.value_name else { continue }
                let label = UILabel()
                label.text = "\(attribute.name): \(value)"
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                attributes.addArrangedSubview(label)
            }
        }
    }
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var attributes: UIStackView!
}

extension ProductDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if UIDevice.current.orientation == .landscapeLeft ||
            UIDevice.current.orientation == .landscapeRight {
            if scrollView.contentOffset.y <= -60 {
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
