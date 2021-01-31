//
//  UIFont+Util.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 31/01/2021.
//

import Foundation
import UIKit

extension UIFont {
    static func rubikMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    static func rubikRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Regular", size: size) ?? .systemFont(ofSize: size)
    }
}
