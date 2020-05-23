//
//  MovieListRequest.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

class MovieListRequest: RequestBuilder {

    typealias Response = Movie

    var urlQueryItem: [URLQueryItem] = []

    var path: String {
        return ""
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        get {
            urlQueryItem
        }
        set {
            urlQueryItem = newValue ?? []
        }
    }
    
}
