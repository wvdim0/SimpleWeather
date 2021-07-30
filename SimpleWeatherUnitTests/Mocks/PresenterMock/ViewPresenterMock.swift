//
//  ViewPresenterMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import UIKit

final class ViewPresenterMock: ViewPresenterProtocol {
    var numberOfWeatherRequests = 0
    var numberOfDisplayedManualInputAlerts = 0

    func getWeather(for requestType: RequestType) {
        numberOfWeatherRequests += 1
    }

    func getWeather(for placeType: PlaceType) {}

    func displayMapViewController() {}

    func displayManualInputAlert() {
        numberOfDisplayedManualInputAlerts += 1
    }

    func getFavoritesViewController() -> UIViewController {
        return UIViewController()
    }

    func getSettingsViewController() -> UIViewController {
        return UIViewController()
    }

    func pushMapViewController() {}
}
