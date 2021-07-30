//
//  MapViewControllerMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import Foundation

final class MapViewControllerMock: MapViewProtocol {
    var numberOfDisplayedLocations = 0
    var numberOfDisplayedAddresses = 0

    func startLoadingAnimation() {}

    func stopLoadingAnimation() {}

    func displayLocation(_ location: Location) {
        numberOfDisplayedLocations += 1
    }

    func displayErrorAlert(with title: String) {}

    func displayAddress(_ address: String) {
        numberOfDisplayedAddresses += 1
    }

    func showUserLocationPlacemark() {}
}
