//
//  UIView+IBInspectable.swift
//  RadishApp
//
//  Created by Omer Elimelech on 7/10/18.
//  Copyright © 2018 BlazingBears. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

    @IBInspectable open var layerBorderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable open var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            } else {
                self.removeShadow()
            }
        }
    }
    @IBInspectable open var borderColor: UIColor? {
        get {
            return self.layer.borderColor != nil ? UIColor.init(cgColor: self.layer.borderColor!) : UIColor.clear
        }
        set {
            self.layer.borderColor = (newValue != nil) ? newValue!.cgColor : UIColor.clear.cgColor
        }
    }
    func addShadow(_ shadowColor: CGColor = UIColor.init(white: 0.8, alpha: 1.0).cgColor, shadowOffset: CGSize = CGSize(width: 0.5, height: 0.5), shadowOpacity: Float = 1.0, shadowRadius: CGFloat = 6.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = self.layer.cornerRadius > 0 ? self.layer.cornerRadius : shadowRadius
    }
    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
    }
    func toolbarShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 5
    }
    
    func loadNib(_ name: String) -> UIView {
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: name, bundle: bundle)
         let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? UIView()
         return view
     }


}

