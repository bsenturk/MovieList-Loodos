//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

class MovieListViewModel {

    private let network = Network()

    var movie: Movie? {
        didSet {
            reloadCollectionView?()
        }
    }

    var reloadCollectionView: (() -> ())?
    var showNoResultPopup: (()->())?


    func getMovieList(searchString: String = "bt") {
        let movieListRequest = MovieListRequest()

        let queryItems = URLQueryItem(name: "apiKey",
                                      value: Constants.Network.apiKey)

        let defaultSearch = URLQueryItem(name: "s", value: searchString)

        movieListRequest.queryItems?.append(queryItems)
        movieListRequest.queryItems?.append(defaultSearch)


        network.request(from: movieListRequest, completion: { result in
            switch result {
            case .success(let movies):
                self.movie = movies as? Movie
            case .failure(_):
                self.showNoResultPopup?()
            }
        })
    }

    func itemsCount() -> Int {
        return movie?.search.count ?? 0
    }
    
}
