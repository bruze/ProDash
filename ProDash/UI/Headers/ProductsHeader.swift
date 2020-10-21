//
//  ProductsHeader.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/21/20.
//

import UIKit

enum ProductsHeaderAction {
    case showAsGrid
    case showAsList
}

protocol ProductsHeaderDelegate {
    func sent(action: ProductsHeaderAction)
}

final class ProductsHeader: UICollectionReusableView {
    static let identifier = "ProductsHeader"
    //MARK: Outlet
    @IBOutlet weak var grid: UIButton!
    @IBOutlet weak var list: UIButton!
    //MARK: Members
    var delegate: ProductsHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: Action
    @IBAction func showAsGrid() {
        grid.isHidden = true
        list.isHidden = false
        delegate?.sent(action: .showAsGrid)
    }
    
    @IBAction func showAsList() {
        list.isHidden = true
        grid.isHidden = false        
        delegate?.sent(action: .showAsList)
    }
}
