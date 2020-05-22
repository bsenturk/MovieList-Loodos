//
//  BaseViewController.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func showAlert(title: String, message: String, actionTitle: String) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle,
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)

        self.present(alertController,
                     animated: true,
                     completion: nil)
    }
}
