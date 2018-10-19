//
//  CardView.swift
//  CardApp
//
//  Created by Jeremy Petter on 2018-10-19.
//  Copyright © 2018 Jeremy Petter. All rights reserved.
//

import UIKit

class CardView: UIView {

    // MARK: - Interface

    var transitionState: TransitionState = .hidden {
        didSet {
            switch transitionState {
            case .hidden:
                dimmingView.alpha = 0
                cardView.transform = CGAffineTransform(translationX: 0, y: 100 + safeAreaInsets.bottom)
            case .shown:
                dimmingView.alpha = 1
                cardView.transform = .identity
            }
        }
    }

    private var contentViewHeight: CGFloat = 100

    private(set) lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimmingView.alpha = 0
        return dimmingView
    }()

    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

    private lazy var contentViewBottomAnchor = contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(dimmingView)
        dimmingView.addSubview(cardView)
        cardView.addSubview(contentView)

        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: bottomAnchor),

            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.heightAnchor.constraint(equalToConstant: contentViewHeight),
            contentView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            contentViewBottomAnchor
            ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    enum TransitionState {
        case hidden, shown
    }

}
