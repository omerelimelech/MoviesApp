//
//  SearchElement.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

class SearchElement: BaseMovie, Codable {
    var title, year, imdbID: String?
    var type: SearchType?
    var poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
