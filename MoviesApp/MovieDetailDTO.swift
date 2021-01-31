//
//  MovieDetailDTO.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

enum MovieDetailDTO {
    struct Request: JsonCodable {
        
        var id: String?
        var apiKey: String = "dce24c91"
        
        enum CodingKeys: String, CodingKey {
            case id = "i"
            case apiKey
        }
    }
    
    struct Response: Codable {
        var movieDeatil: MovieDetail?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            movieDeatil = try container.decode(MovieDetail.self)
        }
    }
    
    struct ViewModel: Codable {
        var movieDetail: MovieDetail?
        init(response: Response) {
            self.movieDetail = response.movieDeatil
        }
    }
}

