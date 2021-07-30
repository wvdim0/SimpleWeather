//
//  RouterMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import XCTest

final class RouterMock: RouterProtocol {
    func setViewControllerAsRootInNavigationController() {}

    func getSettingsViewController() -> UIViewController {
        return UIViewController()
    }

    func getFavoritesViewController() -> UIViewController {
        return UIViewController()
    }

    func pushMapViewController() {}

    func popMapViewController() {}
}
