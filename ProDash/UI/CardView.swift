//
//  CardView.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/20/20.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            refreshUI()
        }
    }

    @IBInspectable public var shadowRadius: Float = 5.0 {
        didSet {
            refreshUI()
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0.2 {
        didSet {
            refreshUI()
        }
    }

    @IBInspectable public var shadowColor: UIColor = UIColor.gray {
        didSet {
            refreshUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        refreshUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshUI()
    }
    
    override func prepareForInterfaceBuilder() {
        refreshUI()
    }
    
    func refreshUI() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOpacity = shadowOpacity
    }
}
