//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

class MovieDetailViewModel {

    private let network = Network()

    var updatePage: ((MovieDetail?)->())?

    func getMovieDetail(title: String, year: String) {
        var movieDetailRequest = MovieDetailRequest()

        let parameterDict: [String: String] = ["apiKey": Constants.Network.apiKey,
                                               "t": title,
                                               "y": year]

        for i in parameterDict {
            movieDetailRequest.urlParameterQuery.append(URLQueryItem(name: i.key,
                                                                     value: i.value))
        }

        network.request(from: movieDetailRequest) { [weak self] result in

            switch result {
            case .success(let movieDetail):
                self?.updatePage?(movieDetail as? MovieDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
}
