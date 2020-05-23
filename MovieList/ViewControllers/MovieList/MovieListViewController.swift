//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

final class MovieListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    private var initialFrame: CGRect?
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
    }()

    private let viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollectionView()
        initializeClosures()
        viewModel.getMovieList()
        adjustNavigationBar()
    }

    private func adjustNavigationBar() {
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    private func initializeCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell().instantiateNib(), forCellWithReuseIdentifier: "MovieCell")
        collectionView.backgroundColor = UIColor(red: 17/255,
                                                 green: 18/255,
                                                 blue: 30/255,
                                                 alpha: 1)
    }

    private func initializeClosures() {
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        viewModel.showNoResultPopup = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert(title: "Uyarı",
                                message: "Film bulunamadı.",
                                actionTitle: "Tamam")
            }
        }
    }

    //MARK: - Animation

    private func expand(cell: UICollectionViewCell) {
        animator.addAnimations {
            self.initialFrame = cell.frame

            cell.frame = CGRect(x: self.collectionView.contentOffset.x,
                                y: 0,
                                width: self.collectionView.frame.width,
                                height: 400)

            self.view.layoutIfNeeded()
        }

        animator.startAnimation()
    }

    //MARK: - Search Bar

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getMovieList(searchString: searchBar.text ?? "")
    }

    //MARK: - Collection View Delegate & Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = viewModel.movie?.search[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let movieDetailViewController = MovieDetailViewController(nibName: "MovieDetailViewController",
//                                                                  bundle: nil)
//        navigationController?.pushViewController(movieDetailViewController, animated: true)

        let cell = collectionView.cellForItem(at: indexPath) ?? UICollectionViewCell()

        expand(cell: cell)

    }
}

