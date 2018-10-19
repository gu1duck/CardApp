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

        customView.dimmingView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(close)
            )
        )
    }

    @objc private func close() {
        dismiss(animated: true)
    }

}
