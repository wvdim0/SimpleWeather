//
//  FavoritesViewControllerMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import Foundation

final class FavoritesViewControllerMock: FavoritesViewProtocol {
    var numberOfLoadingAnimationStops = 0

    func startLoadingAnimation() {}

    func stopLoadingAnimation() {
        numberOfLoadingAnimationStops += 1
    }

    func displayErrorAlert(with title: String) {}

    func addFavoritePlace() {}

    func deleteFavoritePlace(at index: Int) {}

    func displayEmptyTableMessage() {}

    func hideEmptyTableMessage() {}
}
