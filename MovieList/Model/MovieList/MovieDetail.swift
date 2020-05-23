//
//  MovieDetail.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let title: String
    let year: String
    let genre: String
    let plot: String
    let poster: String
    let metascore: String
    let imdbRating: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case plot = "Plot"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating
    }
}
