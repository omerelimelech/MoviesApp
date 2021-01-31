//
//  BaseMovie.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

protocol BaseMovie {
    var title: String? { get set }
    var year: String? { get set }
    var poster: String? { get set }
    var type: SearchType? { get set }
    var imdbID: String? { get set }
    var isSaved: Bool { get }
}

extension BaseMovie {
    var isSaved: Bool {
        guard let id = imdbID else { return false }
        return FavoritesManager.shared.isFavorite(id: id)
    }
}
