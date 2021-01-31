//
//  SearchModel.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

class SearchModel {
    func search(request: SearchMoviesDTO.Request, completion: @escaping (_ result: SearchMoviesDTO.Response?, _ error: APIError?) -> Void) {
        APIManager.shared.request(request: request, responseDTO: SearchMoviesDTO.Response.self) { [weak self] (result, error) in
            guard let _ = self else { return }
            completion(result, error)
        }
    }
}
