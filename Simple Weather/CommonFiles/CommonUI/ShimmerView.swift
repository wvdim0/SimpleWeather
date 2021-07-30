//
//  ShimmerView.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 02.07.2021.
//

import UIKit

final class ShimmerView: UIView {
    // MARK: - UI

    private let shimmerAnimation: CABasicAnimation = {
        let shimmerAnimation = CABasicAnimation(keyPath: "locations")

        shimmerAnimation.fromValue = [-1.0, -0.5, 0.0]
        shimmerAnimation.toValue = [1.0, 1.5, 2.0]
        shimmerAnimation.repeatCount = .infinity
        shimmerAnimation.duration = 1.2

        return shimmerAnimation
    }()

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let colorOne = UIColor.white.withAlphaComponent(0).cgColor
        let colorTwo = UIColor.white.withAlphaComponent(0.1).cgColor

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [colorOne, colorTwo, colorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]

        return gradientLayer
    }()

    // MARK: - Methods

    func setupGradientLayer() {
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
    }

    func startShimmerAnimation() {
        gradientLayer.add(shimmerAnimation, forKey: shimmerAnimation.keyPath)
        gradientLayer.isHidden = false
    }

    func stopShimmerAnimation() {
        gradientLayer.isHidden = true
        gradientLayer.removeAllAnimations()
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.addSublayer(gradientLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
