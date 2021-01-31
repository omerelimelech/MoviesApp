//
//  FavoritesManager.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    let filterByIdPredicateFormat = "id = %@"
    
    func getAllFavotites(predicate: NSPredicate?, completion: @escaping (_ favorites: [FavoriteMovie]?) -> Void) -> Bool {
        return CoreDataManager.shared.get(type: FavoriteMovie.self, entityName: .favoritesMovie, predicate: predicate) { [weak self] (result) in
            guard let _ = self else { return false }
            switch result {
            case .success(let favs):
                completion(favs)
                return true
            case .failure(let error):
                print(error)
                return false
            }
        }
    }
    
    func isFavorite(id: String) -> Bool {
        CoreDataManager.shared.get(type: FavoriteMovie.self, entityName: .favoritesMovie, predicate: NSPredicate(format: filterByIdPredicateFormat, id)) {  [weak self] (result) in
            guard let _ = self else { return false }
            switch result {
            case .success(let favs):
                return favs?.count ?? 0 > 0
            case .failure(let error):
                print(error)
                return false
            }
        }
    }
    
    func saveToDB(id: String, completion: @escaping (_ sucess: Bool) -> Void) {
        guard let favotireEntity = CoreDataManager.shared.getEntity(forType: FavoriteMovie.self, entityName: .favoritesMovie) else { return }
        favotireEntity.id = id
        CoreDataManager.shared.save(entityName: .favoritesMovie, object: favotireEntity, completion: { [weak self] (success) in
            guard let _ = self else { return }
            completion(success)
        })
    }
    
    func deleteFavoriteFromDB(movie: FavoriteMovie, completion: @escaping (_ succes: Bool) -> Void) {
        CoreDataManager.shared.delete(object: movie, completion: completion)
    }
}
