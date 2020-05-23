//
//  FadeAnimation.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

class FadeAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let container = transitionContext.containerView

        container.insertSubview(toView, belowSubview: fromView)

        toView.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0
            toView.alpha = 1
        }) { _ in
            let success = !transitionContext.transitionWasCancelled

            if !success {
                toView.removeFromSuperview()
            }

            transitionContext.completeTransition(success)
        }
    }
}
