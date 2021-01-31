//
//  LikeButtonDelegate.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 31/01/2021.
//

import Foundation

protocol LikeButtonDelegate: class {
    func likeButtonPresenter(_ presenter: LikeButtonPresenter, didAddToFavorites success: Bool)
    func likeButtonPresenter(_ presenter: LikeButtonPresenter, didRemoveFromFavorites success: Bool)
}
