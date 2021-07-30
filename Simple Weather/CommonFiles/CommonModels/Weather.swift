//
//  Weather.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 01.07.2021.
//

import Foundation

struct Weather: Decodable {
    let current: CurrentWeather
    let daily: [DailyWeather]
}

struct CurrentWeather: Decodable {
    let dateTime: Double
    let sunriseDateTime: Int
    let sunsetDateTime: Int
    let temperature: Double
    let feelsLikeTemperature: Double
    let pressure: Double
    let humidity: Int
    let windSpeed: Double
    let windDegrees: Int
    let details: [Details]

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case sunriseDateTime = "sunrise"
        case sunsetDateTime = "sunset"
        case temperature = "temp"
        case feelsLikeTemperature = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case windSpeed = "wind_speed"
        case windDegrees = "wind_deg"
        case details = "weather"
    }
}

struct DailyWeather: Decodable {
    let dateTime: Double
    let temperature: Temperature
    let details: [Details]

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case temperature = "temp"
        case details = "weather"
    }
}

struct Temperature: Decodable {
    let day: Double
    let night: Double
}

struct FeelsLikeTemperature: Decodable {
    let day: Double
    let night: Double
}

struct Details: Decodable {
    let id: Int
    let description: String
    let icon: String
}
