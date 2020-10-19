//
//  RoundButton.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshUI()
        }
    }
    
    /// Border width of the view
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            refreshUI()
        }
    }
    
    /// Border color of the view
    @IBInspectable public var borderColor: UIColor? = nil {
        didSet {
            refreshUI()
        }
    }
    
    /// Border color of the view
    @IBInspectable public var upperCase: Bool = false {
        didSet {
            refreshUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
         refreshUI()
    }
    
    func refreshUI() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor ?? tintColor.cgColor
        if cornerRadius > 0 {
            layer.masksToBounds = true
        }
        if(upperCase){
            self.setTitle(self.titleLabel?.text?.uppercased(), for: UIControl.State.normal)
        }
    }
}
