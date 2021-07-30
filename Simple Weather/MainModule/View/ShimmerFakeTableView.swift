//
//  ShimmerFakeTableView.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 20.07.2021.
//

import UIKit

final class ShimmerFakeTableView: UIView {
    // MARK: - UI

    private let weatherConditionShimmerImageView: ShimmerView = {
        let weatherConditionShimmerImageView = ShimmerView()

        weatherConditionShimmerImageView.backgroundColor = Constants.Colors.middleColor
        weatherConditionShimmerImageView.layer.cornerRadius = 20
        weatherConditionShimmerImageView.translatesAutoresizingMaskIntoConstraints = false

        return weatherConditionShimmerImageView
    }()

    private let temperatureShimmerLabel: ShimmerView = {
        let temperatureShimmerLabel = ShimmerView()

        temperatureShimmerLabel.backgroundColor = Constants.Colors.middleColor
        temperatureShimmerLabel.layer.cornerRadius = 10
        temperatureShimmerLabel.translatesAutoresizingMaskIntoConstraints = false

        return temperatureShimmerLabel
    }()

    private let descriptionShimmerLabel: ShimmerView = {
        let descriptionShimmerLabel = ShimmerView()

        descriptionShimmerLabel.backgroundColor = Constants.Colors.middleColor
        descriptionShimmerLabel.layer.cornerRadius = 10
        descriptionShimmerLabel.translatesAutoresizingMaskIntoConstraints = false

        return descriptionShimmerLabel
    }()

    private let feelsLikeTemperatureShimmerLabel: ShimmerView = {
        let feelsLikeTemperatureShimmerLabel = ShimmerView()

        feelsLikeTemperatureShimmerLabel.backgroundColor = Constants.Colors.middleColor
        feelsLikeTemperatureShimmerLabel.layer.cornerRadius = 10
        feelsLikeTemperatureShimmerLabel.translatesAutoresizingMaskIntoConstraints = false

        return feelsLikeTemperatureShimmerLabel
    }()

    private let windShimmerImageView: ShimmerView = {
        let windShimmerImageView = ShimmerView()

        windShimmerImageView.backgroundColor = Constants.Colors.middleColor
        windShimmerImageView.layer.cornerRadius = 10
        windShimmerImageView.translatesAutoresizingMaskIntoConstraints = false

        return windShimmerImageView
    }()

    private let windShimmerLabel: ShimmerView = {
        let windShimmerLabel = ShimmerView()

        windShimmerLabel.backgroundColor = Constants.Colors.middleColor
        windShimmerLabel.layer.cornerRadius = 10
        windShimmerLabel.translatesAutoresizingMaskIntoConstraints = false

        return windShimmerLabel
    }()

    private let pressureShimmerImageView: ShimmerView = {
        let pressureShimmerImageView = ShimmerView()

        pressureShimmerImageView.backgroundColor = Constants.Colors.middleColor
        pressureShimmerImageView.layer.cornerRadius = 10
        pressureShimmerImageView.translatesAutoresizingMaskIntoConstraints = false

        return pressureShimmerImageView
    }()

    private let pressureShimmerLabel: ShimmerView = {
        let pressureShimmerLabel = ShimmerView()

        pressureShimmerLabel.backgroundColor = Constants.Colors.middleColor
        pressureShimmerLabel.layer.cornerRadius = 10
        pressureShimmerLabel.translatesAutoresizingMaskIntoConstraints = false

        return pressureShimmerLabel
    }()

    private let humidityShimmerImageView: ShimmerView = {
        let humidityShimmerImageView = ShimmerView()

        humidityShimmerImageView.backgroundColor = Constants.Colors.middleColor
        humidityShimmerImageView.layer.cornerRadius = 10
        humidityShimmerImageView.translatesAutoresizingMaskIntoConstraints = false

        return humidityShimmerImageView
    }()

    private let humidityShimmerLabel: ShimmerView = {
        let humidityShimmerLabel = ShimmerView()

        humidityShimmerLabel.backgroundColor = Constants.Colors.middleColor
        humidityShimmerLabel.layer.cornerRadius = 10
        humidityShimmerLabel.translatesAutoresizingMaskIntoConstraints = false

        return humidityShimmerLabel
    }()

    private let dailyWeatherShimmerCellOne: ShimmerView = {
        let dailyWeatherShimmerCellOne = ShimmerView()

        dailyWeatherShimmerCellOne.backgroundColor = Constants.Colors.middleColor
        dailyWeatherShimmerCellOne.layer.cornerRadius = 10
        dailyWeatherShimmerCellOne.translatesAutoresizingMaskIntoConstraints = false

        return dailyWeatherShimmerCellOne
    }()

    private let dailyWeatherShimmerCellTwo: ShimmerView = {
        let dailyWeatherShimmerCellTwo = ShimmerView()

        dailyWeatherShimmerCellTwo.backgroundColor = Constants.Colors.middleColor
        dailyWeatherShimmerCellTwo.layer.cornerRadius = 10
        dailyWeatherShimmerCellTwo.translatesAutoresizingMaskIntoConstraints = false

        return dailyWeatherShimmerCellTwo
    }()

    private let dailyWeatherShimmerCellThree: ShimmerView = {
        let dailyWeatherShimmerCellThree = ShimmerView()

        dailyWeatherShimmerCellThree.backgroundColor = Constants.Colors.middleColor
        dailyWeatherShimmerCellThree.layer.cornerRadius = 10
        dailyWeatherShimmerCellThree.translatesAutoresizingMaskIntoConstraints = false

        return dailyWeatherShimmerCellThree
    }()

    private let dailyWeatherShimmerCellFour: ShimmerView = {
        let dailyWeatherShimmerCellFour = ShimmerView()

        dailyWeatherShimmerCellFour.backgroundColor = Constants.Colors.middleColor
        dailyWeatherShimmerCellFour.layer.cornerRadius = 10
        dailyWeatherShimmerCellFour.translatesAutoresizingMaskIntoConstraints = false

        return dailyWeatherShimmerCellFour
    }()

    private let dailyWeatherShimmerCellFive: ShimmerView = {
        let dailyWeatherShimmerCellFive = ShimmerView()

        dailyWeatherShimmerCellFive.backgroundColor = Constants.Colors.middleColor
        dailyWeatherShimmerCellFive.layer.cornerRadius = 10
        dailyWeatherShimmerCellFive.translatesAutoresizingMaskIntoConstraints = false

        return dailyWeatherShimmerCellFive
    }()

    private let dailyWeatherShimmerCellSix: ShimmerView = {
        let dailyWeatherShimmerCellSix = ShimmerView()

        dailyWeatherShimmerCellSix.backgroundColor = Constants.Colors.middleColor
        dailyWeatherShimmerCellSix.layer.cornerRadius = 10
        dailyWeatherShimmerCellSix.translatesAutoresizingMaskIntoConstraints = false

        return dailyWeatherShimmerCellSix
    }()

    // MARK: - Layout

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override func updateConstraints() {
        super.updateConstraints()

        setupConstraints()
        alsoSetupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        weatherConditionShimmerImageView.setupGradientLayer()
        temperatureShimmerLabel.setupGradientLayer()
        descriptionShimmerLabel.setupGradientLayer()
        feelsLikeTemperatureShimmerLabel.setupGradientLayer()
        windShimmerImageView.setupGradientLayer()
        windShimmerLabel.setupGradientLayer()
        pressureShimmerImageView.setupGradientLayer()
        pressureShimmerLabel.setupGradientLayer()
        humidityShimmerImageView.setupGradientLayer()
        humidityShimmerLabel.setupGradientLayer()
        dailyWeatherShimmerCellOne.setupGradientLayer()
        dailyWeatherShimmerCellTwo.setupGradientLayer()
        dailyWeatherShimmerCellThree.setupGradientLayer()
        dailyWeatherShimmerCellFour.setupGradientLayer()
        dailyWeatherShimmerCellFive.setupGradientLayer()
        dailyWeatherShimmerCellSix.setupGradientLayer()
    }

    // MARK: - Animation control

    func startShimmerAnimation() {
        weatherConditionShimmerImageView.startShimmerAnimation()
        temperatureShimmerLabel.startShimmerAnimation()
        descriptionShimmerLabel.startShimmerAnimation()
        feelsLikeTemperatureShimmerLabel.startShimmerAnimation()
        windShimmerImageView.startShimmerAnimation()
        windShimmerLabel.startShimmerAnimation()
        pressureShimmerImageView.startShimmerAnimation()
        pressureShimmerLabel.startShimmerAnimation()
        humidityShimmerImageView.startShimmerAnimation()
        humidityShimmerLabel.startShimmerAnimation()
        dailyWeatherShimmerCellOne.startShimmerAnimation()
        dailyWeatherShimmerCellTwo.startShimmerAnimation()
        dailyWeatherShimmerCellThree.startShimmerAnimation()
        dailyWeatherShimmerCellFour.startShimmerAnimation()
        dailyWeatherShimmerCellFive.startShimmerAnimation()
        dailyWeatherShimmerCellSix.startShimmerAnimation()

        isHidden = false
    }

    func stopShimmerAnimation() {
        weatherConditionShimmerImageView.stopShimmerAnimation()
        temperatureShimmerLabel.stopShimmerAnimation()
        descriptionShimmerLabel.stopShimmerAnimation()
        feelsLikeTemperatureShimmerLabel.stopShimmerAnimation()
        windShimmerImageView.stopShimmerAnimation()
        windShimmerLabel.stopShimmerAnimation()
        pressureShimmerImageView.stopShimmerAnimation()
        pressureShimmerLabel.stopShimmerAnimation()
        humidityShimmerImageView.stopShimmerAnimation()
        humidityShimmerLabel.stopShimmerAnimation()
        dailyWeatherShimmerCellOne.stopShimmerAnimation()
        dailyWeatherShimmerCellTwo.stopShimmerAnimation()
        dailyWeatherShimmerCellThree.stopShimmerAnimation()
        dailyWeatherShimmerCellFour.stopShimmerAnimation()
        dailyWeatherShimmerCellFive.stopShimmerAnimation()
        dailyWeatherShimmerCellSix.stopShimmerAnimation()

        isHidden = true
    }

    // MARK: - Private methods

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherConditionShimmerImageView.widthAnchor.constraint(equalToConstant: 170),
            weatherConditionShimmerImageView.heightAnchor.constraint(equalToConstant: 170),
            weatherConditionShimmerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherConditionShimmerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),

            temperatureShimmerLabel.widthAnchor.constraint(equalToConstant: 80),
            temperatureShimmerLabel.heightAnchor.constraint(equalToConstant: 45),
            temperatureShimmerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureShimmerLabel.topAnchor.constraint(equalTo: weatherConditionShimmerImageView.bottomAnchor,
                                                         constant: 20),

            descriptionShimmerLabel.widthAnchor.constraint(equalToConstant: 180),
            descriptionShimmerLabel.heightAnchor.constraint(equalToConstant: 20),
            descriptionShimmerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionShimmerLabel.topAnchor.constraint(equalTo: temperatureShimmerLabel.bottomAnchor, constant: 20),

            feelsLikeTemperatureShimmerLabel.widthAnchor.constraint(equalToConstant: 180),
            feelsLikeTemperatureShimmerLabel.heightAnchor.constraint(equalToConstant: 20),
            feelsLikeTemperatureShimmerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            feelsLikeTemperatureShimmerLabel.topAnchor.constraint(equalTo: descriptionShimmerLabel.bottomAnchor,
                                                                  constant: 20),

            pressureShimmerImageView.widthAnchor.constraint(equalToConstant: 40),
            pressureShimmerImageView.heightAnchor.constraint(equalToConstant: 40),
            pressureShimmerImageView.trailingAnchor.constraint(equalTo: humidityShimmerImageView.leadingAnchor,
                                                               constant: -60),
            pressureShimmerImageView.topAnchor.constraint(equalTo: feelsLikeTemperatureShimmerLabel.bottomAnchor,
                                                          constant: 20),

            humidityShimmerImageView.widthAnchor.constraint(equalToConstant: 40),
            humidityShimmerImageView.heightAnchor.constraint(equalToConstant: 40),
            humidityShimmerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            humidityShimmerImageView.topAnchor.constraint(equalTo: feelsLikeTemperatureShimmerLabel.bottomAnchor,
                                                          constant: 20),

            windShimmerImageView.widthAnchor.constraint(equalToConstant: 40),
            windShimmerImageView.heightAnchor.constraint(equalToConstant: 40),
            windShimmerImageView.leadingAnchor.constraint(equalTo: humidityShimmerImageView.trailingAnchor,
                                                          constant: 60),
            windShimmerImageView.topAnchor.constraint(equalTo: feelsLikeTemperatureShimmerLabel.bottomAnchor,
                                                      constant: 20),

            pressureShimmerLabel.widthAnchor.constraint(equalToConstant: 80),
            pressureShimmerLabel.heightAnchor.constraint(equalToConstant: 45),
            pressureShimmerLabel.centerXAnchor.constraint(equalTo: pressureShimmerImageView.centerXAnchor),
            pressureShimmerLabel.topAnchor.constraint(equalTo: humidityShimmerImageView.bottomAnchor, constant: 10)
        ])
    }

    private func alsoSetupConstraints() {
        NSLayoutConstraint.activate([
            humidityShimmerLabel.widthAnchor.constraint(equalToConstant: 80),
            humidityShimmerLabel.heightAnchor.constraint(equalToConstant: 45),
            humidityShimmerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            humidityShimmerLabel.topAnchor.constraint(equalTo: humidityShimmerImageView.bottomAnchor, constant: 10),

            windShimmerLabel.widthAnchor.constraint(equalToConstant: 80),
            windShimmerLabel.heightAnchor.constraint(equalToConstant: 45),
            windShimmerLabel.centerXAnchor.constraint(equalTo: windShimmerImageView.centerXAnchor),
            windShimmerLabel.topAnchor.constraint(equalTo: humidityShimmerImageView.bottomAnchor, constant: 10),

            dailyWeatherShimmerCellOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dailyWeatherShimmerCellOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dailyWeatherShimmerCellOne.heightAnchor.constraint(equalToConstant: 20),
            dailyWeatherShimmerCellOne.topAnchor.constraint(equalTo: humidityShimmerLabel.bottomAnchor, constant: 42),

            dailyWeatherShimmerCellTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dailyWeatherShimmerCellTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dailyWeatherShimmerCellTwo.heightAnchor.constraint(equalToConstant: 20),
            dailyWeatherShimmerCellTwo.topAnchor.constraint(equalTo: dailyWeatherShimmerCellOne.bottomAnchor,
                                                            constant: 47),

            dailyWeatherShimmerCellThree.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dailyWeatherShimmerCellThree.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dailyWeatherShimmerCellThree.heightAnchor.constraint(equalToConstant: 20),
            dailyWeatherShimmerCellThree.topAnchor.constraint(equalTo: dailyWeatherShimmerCellTwo.bottomAnchor,
                                                              constant: 47),

            dailyWeatherShimmerCellFour.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dailyWeatherShimmerCellFour.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dailyWeatherShimmerCellFour.heightAnchor.constraint(equalToConstant: 20),
            dailyWeatherShimmerCellFour.topAnchor.constraint(equalTo: dailyWeatherShimmerCellThree.bottomAnchor,
                                                             constant: 47),

            dailyWeatherShimmerCellFive.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dailyWeatherShimmerCellFive.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dailyWeatherShimmerCellFive.heightAnchor.constraint(equalToConstant: 20),
            dailyWeatherShimmerCellFive.topAnchor.constraint(equalTo: dailyWeatherShimmerCellFour.bottomAnchor,
                                                             constant: 47),

            dailyWeatherShimmerCellSix.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dailyWeatherShimmerCellSix.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dailyWeatherShimmerCellSix.heightAnchor.constraint(equalToConstant: 20),
            dailyWeatherShimmerCellSix.topAnchor.constraint(equalTo: dailyWeatherShimmerCellFive.bottomAnchor,
                                                            constant: 47)
        ])
    }

    private func addSubviews() {
        addSubview(weatherConditionShimmerImageView)
        addSubview(temperatureShimmerLabel)
        addSubview(descriptionShimmerLabel)
        addSubview(feelsLikeTemperatureShimmerLabel)
        addSubview(windShimmerImageView)
        addSubview(windShimmerLabel)
        addSubview(pressureShimmerImageView)
        addSubview(pressureShimmerLabel)
        addSubview(humidityShimmerImageView)
        addSubview(humidityShimmerLabel)
        addSubview(dailyWeatherShimmerCellOne)
        addSubview(dailyWeatherShimmerCellTwo)
        addSubview(dailyWeatherShimmerCellThree)
        addSubview(dailyWeatherShimmerCellFour)
        addSubview(dailyWeatherShimmerCellFive)
        addSubview(dailyWeatherShimmerCellSix)
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Constants.Colors.mainBackgroundColor
        isHidden = true

        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
