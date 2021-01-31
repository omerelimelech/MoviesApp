//
//  BaseButton.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 31/01/2021.
//

import Foundation
import UIKit

class BaseButton: UIButton {
    weak var nibView: UIView!

    func initialConfig() {
         let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
         let nib = loadNib(nibName)
         nib.frame = bounds
         nib.translatesAutoresizingMaskIntoConstraints = true
         addSubview(nib)
         nib.backgroundColor = .clear
         nibView = nib
     }
}
