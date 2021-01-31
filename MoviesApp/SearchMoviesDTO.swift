//
//  SearchMoviesDTO.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

enum SearchMoviesDTO {
    struct Request: JsonCodable {
    
        var apiKey: String = "dce24c91"
        var title: String?
        var type: SearchType?
        var year: String?
        var page: Int?
        
        enum CodingKeys: String, CodingKey {
            case title = "s"
            case year = "y"
            case page, type, apiKey
        }
    }
    
    struct Response: Codable {
        var searchResults: [SearchElement]?
        var totalResults, response: String?

        enum CodingKeys: String, CodingKey {
            case searchResults = "Search"
            case totalResults
            case response = "Response"
        }
    }
    
    struct ViewModel: Codable {
        var searchResults: [SearchElement]?
        var totalResults, response: String?
        init(response: Response) {
            self.searchResults = response.searchResults
            self.totalResults = response.totalResults
            self.response = response.response
        }
    }
}
