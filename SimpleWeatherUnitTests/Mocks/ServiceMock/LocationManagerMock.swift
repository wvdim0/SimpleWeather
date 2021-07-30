//
//  LocationManagerMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import Foundation

final class LocationManagerMock: LocationManagerProtocol {
    func getUserLocation(completion: @escaping LocationHandler) {
        completion(.success(Location(latitude: 55.754679, longitude: 37.628667)))
    }
}
