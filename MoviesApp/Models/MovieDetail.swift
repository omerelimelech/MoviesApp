//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

class MovieDetail: BaseMovie, Codable {
    
    var title, year, rated, released: String?
    var runtime, genre, director, writer: String?
    var actors, plot, language, country: String?
    var awards: String?
    var poster: String?
    var ratings: [Rating]?
    var metascore, imdbRating, imdbVotes, imdbID: String?
    var totalSeasons, response: String?
    var type: SearchType?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case totalSeasons
        case response = "Response"
    }
}

// MARK: - Rating
class Rating: Codable {
    var source, value: String?

    enum CodingKeys: String, CodingKey {
        case source
        case value
    }

    init(source: String?, value: String?) {
        self.source = source
        self.value = value
    }
}
