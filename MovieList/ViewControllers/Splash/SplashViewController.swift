//
//  SplashViewController.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit
import Reachability

class SplashViewController: BaseViewController {

    @IBOutlet weak var splashTextLabel: UILabel!

    private let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeInternetConnection()
    }

    //MARK: - Internet Connection

    private func observeInternetConnection() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }

    @objc
    func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi, .cellular:
          navigateMainScreen()
      case .unavailable:
        showAlert(title: "Uyarı",
                  message: "İnternet bağlantınız yok!",
                  actionTitle: "Tamam")
      case .none:
        break
        }
    }

    //MARK: - Navigation

    private func navigateMainScreen() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            let movieListViewController = MovieListViewController()

            let navigationController = UINavigationController(rootViewController: movieListViewController)

            self.present(navigationController,
                         animated: false,
                         completion: nil)
        }
    }

}
