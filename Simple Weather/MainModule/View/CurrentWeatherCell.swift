//
//  CurrentWeatherCell.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 10.07.2021.
//

import UIKit

final class CurrentWeatherCell: UITableViewCell {
    // MARK: - UI

    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()

        backgroundImageView.image = UIImage(named: "City")
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.alpha = 0.1
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        return backgroundImageView
    }()

    private let weatherConditionImageView: UIImageView = {
        let weatherConditionImageView = UIImageView()

        weatherConditionImageView.image = UIImage(named: "RainDay")
        weatherConditionImageView.tintColor = .orange
        weatherConditionImageView.contentMode = .scaleAspectFit
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false

        return weatherConditionImageView
    }()

    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()

        temperatureLabel.text = "21°"
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont(name: "Avenir Next Bold", size: 45)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        return temperatureLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()

        descriptionLabel.text = "Небольшой дождь"
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont(name: "Avenir Next", size: 18)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        return descriptionLabel
    }()

    private let feelsLikeTemperatureLabel: UILabel = {
        let feelsLikeTemperatureLabel = UILabel()

        feelsLikeTemperatureLabel.text = "Ощущается как 19°"
        feelsLikeTemperatureLabel.textAlignment = .center
        feelsLikeTemperatureLabel.textColor = .white
        feelsLikeTemperatureLabel.font = UIFont(name: "Avenir Next", size: 18)
        feelsLikeTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        return feelsLikeTemperatureLabel
    }()

    private let windImageView: UIImageView = {
        let windImageView = UIImageView()

        windImageView.image = UIImage(systemName: "wind")
        windImageView.tintColor = .white
        windImageView.contentMode = .scaleAspectFit
        windImageView.translatesAutoresizingMaskIntoConstraints = false

        return windImageView
    }()

    private let windLabel: UILabel = {
        let windLabel = UILabel()

        windLabel.text = "Ветер\n2 м/c, ЮВ"
        windLabel.numberOfLines = 2
        windLabel.textAlignment = .center
        windLabel.textColor = .white
        windLabel.font = UIFont(name: "Avenir Next", size: 14)
        windLabel.translatesAutoresizingMaskIntoConstraints = false

        return windLabel
    }()

    private let pressureImageView: UIImageView = {
        let pressureImageView = UIImageView()

        pressureImageView.image = UIImage(systemName: "barometer")
        pressureImageView.tintColor = .white
        pressureImageView.contentMode = .scaleAspectFit
        pressureImageView.translatesAutoresizingMaskIntoConstraints = false

        return pressureImageView
    }()

    private let pressureLabel: UILabel = {
        let pressureLabel = UILabel()

        pressureLabel.text = "Давление\n747 мм.рт.ст"
        pressureLabel.numberOfLines = 2
        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .white
        pressureLabel.font = UIFont(name: "Avenir Next", size: 14)
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false

        return pressureLabel
    }()

    private let humidityImageView: UIImageView = {
        let humidityImageView = UIImageView()

        humidityImageView.image = UIImage(systemName: "drop")
        humidityImageView.tintColor = .white
        humidityImageView.contentMode = .scaleAspectFit
        humidityImageView.translatesAutoresizingMaskIntoConstraints = false

        return humidityImageView
    }()

    private let humidityLabel: UILabel = {
        let humidityLabel = UILabel()

        humidityLabel.text = "Влажность\n65%"
        humidityLabel.numberOfLines = 2
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont(name: "Avenir Next", size: 14)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false

        return humidityLabel
    }()

    // MARK: - Layout

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),

            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 190),
            weatherConditionImageView.widthAnchor.constraint(equalToConstant: 190),
            weatherConditionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            weatherConditionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            temperatureLabel.topAnchor.constraint(equalTo: weatherConditionImageView.bottomAnchor, constant: 0),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),

            feelsLikeTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            feelsLikeTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            feelsLikeTemperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),

            windImageView.heightAnchor.constraint(equalToConstant: 40),
            windImageView.widthAnchor.constraint(equalToConstant: 40),
            windImageView.topAnchor.constraint(equalTo: feelsLikeTemperatureLabel.bottomAnchor, constant: 20),
            windImageView.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 60),

            windLabel.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 10),
            windLabel.centerXAnchor.constraint(equalTo: windImageView.centerXAnchor),

            humidityImageView.heightAnchor.constraint(equalToConstant: 40),
            humidityImageView.widthAnchor.constraint(equalToConstant: 40),
            humidityImageView.topAnchor.constraint(equalTo: feelsLikeTemperatureLabel.bottomAnchor, constant: 20),
            humidityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            humidityLabel.topAnchor.constraint(equalTo: humidityImageView.bottomAnchor, constant: 10),
            humidityLabel.centerXAnchor.constraint(equalTo: humidityImageView.centerXAnchor),
            humidityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            pressureImageView.heightAnchor.constraint(equalToConstant: 40),
            pressureImageView.widthAnchor.constraint(equalToConstant: 40),
            pressureImageView.trailingAnchor.constraint(equalTo: humidityImageView.leadingAnchor, constant: -60),
            pressureImageView.topAnchor.constraint(equalTo: feelsLikeTemperatureLabel.bottomAnchor, constant: 20),

            pressureLabel.topAnchor.constraint(equalTo: pressureImageView.bottomAnchor, constant: 10),
            pressureLabel.centerXAnchor.constraint(equalTo: pressureImageView.centerXAnchor)
        ])
    }

    // MARK: - Configuring

    func configure(with resultWeather: ResultWeather?) {
        guard let resultWeather = resultWeather else { return }

        weatherConditionImageView.image = UIImage(named: resultWeather.current.weatherConditionImageName)
        temperatureLabel.text = resultWeather.current.temperature
        descriptionLabel.text = resultWeather.current.description
        feelsLikeTemperatureLabel.text = resultWeather.current.feelsLikeTemperature
        pressureLabel.text = resultWeather.current.pressure
        humidityLabel.text = resultWeather.current.humidity
        windLabel.text = resultWeather.current.wind
    }

    // MARK: - Private methods

    private func addSubviews() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(feelsLikeTemperatureLabel)
        contentView.addSubview(windImageView)
        contentView.addSubview(windLabel)
        contentView.addSubview(pressureImageView)
        contentView.addSubview(pressureLabel)
        contentView.addSubview(humidityImageView)
        contentView.addSubview(humidityLabel)
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
        contentView.clipsToBounds = true

        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
