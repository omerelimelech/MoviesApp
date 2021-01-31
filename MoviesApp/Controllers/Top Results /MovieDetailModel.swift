//
//  ResultsModel.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

class MovieDetailModel {
    func getMovieDetail(request: MovieDetailDTO.Request, completion: @escaping (_ result: MovieDetailDTO.Response?, _ error: APIError?) -> Void) {
        APIManager.shared.request(request: request, responseDTO: MovieDetailDTO.Response.self) { [weak self] (response, error) in
            guard let _ = self else { return }
            completion(response, error)
        }
    }
}
