//
//  BaseViewController.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private let containerView = UIView()

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

    func presentViewController(viewController: UIViewController, animated: Bool, completion: (()->Void)?) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: animated, completion: completion)
    }

    private func createLoadingIndicator() {

        containerView.frame  = CGRect(origin: .zero,
                                      size: CGSize(width: 50, height: 50))
        
        containerView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)

        containerView.backgroundColor = .clear

        view.addSubview(containerView)

        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0.75
        shapeLayer.lineWidth = 2

        containerView.layer.addSublayer(shapeLayer)

        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        basicAnimation.duration = 0.3
        basicAnimation.fromValue = 0
        basicAnimation.toValue = CGFloat(Double.pi * 2)
        basicAnimation.repeatCount = .infinity
        containerView.layer.add(basicAnimation, forKey: "rotation")
    }

    func showLodingIndicator() {
        createLoadingIndicator()
    }

    func hideLoadingIndicator() {
        containerView.removeFromSuperview()
    }
}
