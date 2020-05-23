//
//  MovieCell.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!

    var movie: MovieSearch? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.alpha = 0
    }

    private func updateView() {
        let url = URL(string: movie?.poster ?? "")
        movieImageView.sd_setImage(with: url)

        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.movieImageView.alpha = 1
        }, completion: nil)
    }

}
