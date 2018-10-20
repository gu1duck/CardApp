//
//  CardViewController.swift
//  CardApp
//
//  Created by Jeremy Petter on 2018-10-19.
//  Copyright © 2018 Jeremy Petter. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    private lazy var customView = CardView(frame: UIScreen.main.bounds)

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(raiseCard), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lowerCard), name: UIApplication.keyboardWillHideNotification, object: nil)

        customView.dimmingView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(close)
            )
        )

        customView.layoutIfNeeded()
        customView.textfield.becomeFirstResponder()
    }

    @objc private func close() {
        customView.endEditing(true)
        dismiss(animated: true)
    }

    @objc private func raiseCard(notification: Notification) {
        guard let frame = notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect,
        let duration = notification.userInfo?[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }

        UIView.animate(withDuration: duration) {
            self.customView.contentViewBottomAnchor.constant = -(frame.height - self.customView.safeAreaInsets.bottom)
            self.customView.layoutIfNeeded()
        }
    }

    @objc private func lowerCard(notification: Notification) {
        guard let duration = notification.userInfo?[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

        UIView.animate(withDuration: duration) {
            self.customView.contentViewBottomAnchor.constant = 0
            self.customView.layoutIfNeeded()
        }
    }

}
