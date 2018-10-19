//
//  ViewController.swift
//  CardApp
//
//  Created by Jeremy Petter on 2018-10-19.
//  Copyright © 2018 Jeremy Petter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("show card", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor),
            button.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor),
            ])

        button.addTarget(self, action: #selector(showCard), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func showCard() {
        let cardViewController = CardViewController()
        cardViewController.modalPresentationStyle = .overCurrentContext
        cardViewController.transitioningDelegate = self
        present(cardViewController, animated: true)
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(context: .presenting)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(context: .dismissing)
    }
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private let context: Context

    init(context: Context) {
        self.context = context
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)

        switch context {
        case .presenting:
            guard let cardView = transitionContext.view(forKey: .to) as? CardView else { return }
            transitionContext.containerView.addSubview(cardView)
            cardView.layoutIfNeeded() // lay out elements and set safe area margins
            cardView.transitionState = .hidden
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
                cardView.transitionState = .shown
            }, completion: { didComplete in
                transitionContext.completeTransition(didComplete)
            })
        case .dismissing:
            guard let cardView = transitionContext.view(forKey: .from) as? CardView else { return }
            cardView.transitionState = .shown
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
                cardView.transitionState = .hidden
            }, completion: { didComplete in
                cardView.removeFromSuperview()
                transitionContext.completeTransition(didComplete)
            })
        }
    }

    enum Context {
        case presenting, dismissing
    }

}

