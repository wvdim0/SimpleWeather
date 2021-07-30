//
//  NetworkManagerMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import Foundation

final class NetworkManagerMock: NetworkManagerProtocol {
    var numberOfRequestsForCity = 0
    var numberOfRequestsForCoordinates = 0

    func performRequest(for requestType: NetworkRequestType, completion: @escaping WeatherHandler) {
        switch requestType {
        case .city:
            numberOfRequestsForCity += 1

            let fakeResultWeather = ResultWeatherMock().resultWeather

            completion(.success(fakeResultWeather))
        case .coordinates:
            numberOfRequestsForCoordinates += 1

            completion(.failure(CustomError(description: "Weather data not found")))
        }
    }

    func loadImage(_ handler: @escaping LoadImageHandler) {}
}
