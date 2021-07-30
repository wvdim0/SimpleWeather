//
//  ResultWeatherMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import Foundation

final class ResultWeatherMock {
    private let weatherLocation = WeatherLocation(city: "Moscow",
                                                  coordinates: Coordinates(latitude: 0.0, longitude: 0.0),
                                                  timeZoneOffset: 0)

    private let currentWeather = CurrentWeather(dateTime: 0,
                                                sunriseDateTime: 0,
                                                sunsetDateTime: 0,
                                                temperature: 25.0,
                                                feelsLikeTemperature: 22.0,
                                                pressure: 1000,
                                                humidity: 100,
                                                windSpeed: 5,
                                                windDegrees: 310,
                                                details: [Details(id: 0, description: "", icon: "")])

    private let dailyWeather = DailyWeather(dateTime: 0,
                                            temperature: Temperature(day: 30.0, night: 15.0),
                                            details: [Details(id: 0, description: "", icon: "")])

    private lazy var weather = Weather(current: currentWeather, daily: [dailyWeather])

    lazy var resultWeather = ResultWeather(weatherLocation: weatherLocation, weather: weather)
}
