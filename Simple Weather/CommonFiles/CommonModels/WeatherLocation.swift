//
//  WeatherLocation.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 03.06.2021.
//

import Foundation

struct WeatherLocation: Decodable {
    let city: String
    let coordinates: Coordinates
    let timeZoneOffset: Int

    enum CodingKeys: String, CodingKey {
        case city = "name"
        case coordinates = "coord"
        case timeZoneOffset = "timezone"
    }
}

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
