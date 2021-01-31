//
//  AlertViewController+Utils.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 31/01/2021.
//

import Foundation
import UIKit

extension UIAlertController {
    static func serverError() -> UIAlertController {
        let alert = UIAlertController(title: "Server Error", message: "Please try again later or modify your search", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        return alert
    }
    
    static func movieTitleMissing() -> UIAlertController {
        let alert = UIAlertController(title: "Movie title is missing", message: "Please modify your search", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        return alert
    }
    
}
