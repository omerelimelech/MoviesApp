//
//  APIError.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 31/01/2021.
//

import Foundation

enum APIError: Error {
    case noResults(ServerError)
    case parseError(ServerError)
    case decodeError(ServerError)
    case serverError
}
