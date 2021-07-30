//
//  DailyWeatherCell.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 10.07.2021.
//

import UIKit

final class DailyWeatherCell: UITableViewCell {
    // MARK: - Properties

    static let cellID = "dailyWeatherCell"

    // MARK: - UI

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()

        dateLabel.text = "1 июля"
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        dateLabel.font = UIFont(name: "Avenir Next", size: 14)
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        return dateLabel
    }()

    private let weekdayLabel: UILabel = {
        let weekdayLabel = UILabel()

        weekdayLabel.text = "Понедельник"
        weekdayLabel.textColor = .white
        weekdayLabel.font = UIFont(name: "Avenir Next", size: 18)
        weekdayLabel.textAlignment = .center
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false

        return weekdayLabel
    }()

    private let weatherConditionImageView: UIImageView = {
        let weatherConditionImageView = UIImageView()

        weatherConditionImageView.image = UIImage(named: "Mist")
        weatherConditionImageView.contentMode = .scaleAspectFit
        weatherConditionImageView.tintColor = .orange
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false

        return weatherConditionImageView
    }()

    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()

        temperatureLabel.text = "19°"
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont(name: "Avenir Next Bold", size: 18)
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        return temperatureLabel
    }()

    private let feelsLikeTemperatureLabel: UILabel = {
        let feelsLikeTemperatureLabel = UILabel()

        feelsLikeTemperatureLabel.text = "12°"
        feelsLikeTemperatureLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        feelsLikeTemperatureLabel.font = UIFont(name: "Avenir Next", size: 18)
        feelsLikeTemperatureLabel.textAlignment = .center
        feelsLikeTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        return feelsLikeTemperatureLabel
    }()

    // MARK: - Layout

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            weekdayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            weekdayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            weekdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            weatherConditionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherConditionImageView.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -10),
            weatherConditionImageView.widthAnchor.constraint(equalToConstant: 37),
            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 30),

            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: feelsLikeTemperatureLabel.leadingAnchor, constant: -10),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 37),

            feelsLikeTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            feelsLikeTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            feelsLikeTemperatureLabel.widthAnchor.constraint(equalToConstant: 37)
        ])
    }

    // MARK: - Configuring

    func configure(with resultWeather: ResultWeather?, index: Int) {
        guard let resultWeather = resultWeather else { return }

        dateLabel.text = resultWeather.daily.dates[index]
        weekdayLabel.text = resultWeather.daily.weekdays[index]
        weatherConditionImageView.image = UIImage(named: resultWeather.daily.weatherConditionImageNames[index])
        temperatureLabel.text = resultWeather.daily.dayTemperatures[index]
        feelsLikeTemperatureLabel.text = resultWeather.daily.nightTemperatures[index]
    }

    // MARK: - Private methods

    func addSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(weekdayLabel)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(feelsLikeTemperatureLabel)
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none

        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
