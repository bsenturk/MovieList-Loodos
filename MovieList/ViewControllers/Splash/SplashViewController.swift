//
//  SplashViewController.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit
import Reachability

final class SplashViewController: BaseViewController {

    @IBOutlet weak var splashTextLabel: UILabel!

    private let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(observeRemoteConfigLoad),
                                               name: .didRemoteConfigLoaded,
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeInternetConnection()
    }

    @objc
    func observeRemoteConfigLoad() {
        let text = RemoteConfigValues.splashText.getStringValue()
        splashTextLabel.text = text
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            let movieListViewController = MovieListViewController(nibName: "MovieListViewController",
                                                                  bundle: nil)

            let navigationController = UINavigationController(rootViewController: movieListViewController)

            self?.presentViewController(viewController: navigationController,
                         animated: true)
        }
    }

    deinit {
        print("deinit..")
    }

}
