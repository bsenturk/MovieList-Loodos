//
//  Movie.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

struct Movie: Decodable {

    let search: [MovieSearch]

    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct MovieSearch: Decodable {

    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
