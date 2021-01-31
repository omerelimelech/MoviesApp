//
//  LikeButtonPresenter.swift
//
//  Created by Omer Elimelech on 03/09/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

class LikeButtonPresenter: NSObject {

    weak var delegate: LikeButtonDelegate?
    var model = LikeButtonModel()
    
    init(delegate: LikeButtonDelegate) {
        self.delegate = delegate
    }

    func likeButtonTapped(isSelected: Bool, movieId: String?) {
        guard let movieId = movieId else { return }
        if isSelected {
            removeFromDB(id: movieId)
        } else {
            saveToDB(id: movieId)
        }
    }
    
    private func removeFromDB(id: String) {
        let _ = FavoritesManager.shared.getAllFavotites(predicate: NSPredicate(format: FavoritesManager.shared.filterByIdPredicateFormat, id)) {  [weak self] (favorites) in
            guard let self = self else { return }
            favorites?.forEach({FavoritesManager.shared.deleteFavoriteFromDB(movie: $0) { [weak self] (success) in
                guard let self = self else { return }
                self.delegate?.likeButtonPresenter(self, didRemoveFromFavorites: success)
            }})
        }
    }
    
    private func saveToDB(id: String) {
        FavoritesManager.shared.saveToDB(id: id, completion: { [weak self] (success) in
            guard let self = self else { return }
            self.delegate?.likeButtonPresenter(self, didAddToFavorites: success)
        })
    }

}

class LikeButtonModel: NSObject {
    
}
