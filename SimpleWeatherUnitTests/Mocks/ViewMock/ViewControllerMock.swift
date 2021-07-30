//
//  ViewControllerMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import Foundation

final class ViewControllerMock: ViewProtocol {
    var numberOfDisplayedErrorAlerts = 0
    var numberOfDisplayedMapViewControllers = 0
    var numberOfInterfaceUpdates = 0
    var numberOfDisplayedManualInputAlerts = 0

    var isLoadingAnimationInProcess = false

    func updateInterface(with resultWeather: ResultWeather) {
        numberOfInterfaceUpdates += 1
    }

    func displayErrorAlert(with title: String) {
        numberOfDisplayedErrorAlerts += 1
    }

    func startLoadingAnimation() {}

    func stopLoadingAnimation() {}

    func displayMapViewController() {
        numberOfDisplayedMapViewControllers += 1
    }

    func displayManualInputAlert() {
        numberOfDisplayedManualInputAlerts += 1
    }
}
