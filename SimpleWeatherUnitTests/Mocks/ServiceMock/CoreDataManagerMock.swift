//
//  CoreDataManagerMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import Foundation

final class CoreDataManagerMock: CoreDataManagerProtocol {
    var favoritePlaces = [String]()

    func addFavoritePlace(with name: String) {
        favoritePlaces.append(name)
    }

    func deleteFavoritePlace(at index: Int) {
        favoritePlaces.remove(at: index)
    }

    func getFavoritePlaces() -> [String] {
        return favoritePlaces
    }
}
