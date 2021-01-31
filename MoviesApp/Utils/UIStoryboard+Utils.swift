//
//  UIStoryboard+Utils.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation
import UIKit

enum AppStoryboards: String {
    case main = "Main"
}

extension UIStoryboard {
    static func instantiateViewController<T: UIViewController>(type: T.Type, storyBoard storyboard: AppStoryboards) -> T {
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: String(describing: type)) as? T ?? T()
    }
}

