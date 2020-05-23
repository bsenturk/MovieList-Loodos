//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var metascoreLabel: UILabel!
    @IBOutlet weak var smallPosterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!

    private let viewModel = MovieDetailViewModel()

    var movieTitle: String = ""
    var year: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        initializeClosures()
        viewModel.getMovieDetail(title: movieTitle, year: year)
    }

    private func initializeClosures() {
        viewModel.updatePage = { [weak self] movieDetail in
            DispatchQueue.main.async {
                let url = URL(string: movieDetail?.poster ?? "")
                self?.moviePosterImageView.sd_setImage(with: url)
                self?.movieTitleLabel.text = "\(movieDetail?.title.uppercased() ?? "") (\(movieDetail?.year ?? ""))"
                self?.genreLabel.text = movieDetail?.genre
                self?.smallPosterImageView.sd_setImage(with: url)
                self?.descriptionLabel.text = movieDetail?.plot
                self?.adjustMetascoreLabel(metascoreText: movieDetail?.metascore ?? "")
                self?.imdbRatingLabel.text = "\(movieDetail?.imdbRating ?? "") / 10"
                AnalyticsEvent.movieDetail(movieDetail?.title ?? "",
                                           movieDetail?.year ?? "",
                                           movieDetail?.plot ?? "").sendEvent()
            }
        }
    }

    private func applyStyling() {
        genreLabel.layer.borderWidth = 0.5
        genreLabel.layer.borderColor = UIColor.white.cgColor
        genreLabel.layer.cornerRadius = 10

        smallPosterImageView.layer.cornerRadius = 10

    }

    func adjustMetascoreLabel(metascoreText: String) {
        let metascore = Int(metascoreText) ?? 0
        var foregroundColor = UIColor()

        if metascore >= 70 {
            foregroundColor = UIColor.green
        } else if metascore >= 40 && metascore <= 69 {
            foregroundColor = UIColor.yellow
        } else {
            foregroundColor = UIColor.red
        }

        let mutableAttributedString = NSMutableAttributedString(string: metascoreText, attributes: [NSAttributedString.Key.foregroundColor : foregroundColor])
        let attributedText = NSAttributedString(string: "\nMetascore",
                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        mutableAttributedString.append(attributedText)
        metascoreLabel.attributedText = mutableAttributedString
    }

}
