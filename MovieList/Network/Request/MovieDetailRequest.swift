//
//  MovieDetailRequest.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

struct MovieDetailRequest: RequestBuilder {
    typealias Response = MovieDetail

    var urlParameterQuery: [URLQueryItem] = []

    var path: String {
        return ""
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        get {
            urlParameterQuery
        }
        set {
            urlParameterQuery = newValue ?? []
        }
    }

}
