//
//  ServerError.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 31/01/2021.
//

import Foundation

struct ServerError: Codable {
    var error: String
    var response: String
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}
