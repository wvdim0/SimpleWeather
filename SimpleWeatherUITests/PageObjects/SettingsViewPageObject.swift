//
//  SettingsViewPageObject.swift
//  SimpleWeatherUITests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import Foundation
import XCTest

protocol SettingsViewPageObjectProtocol {
    var app: XCUIApplication { get }

    var closeButton: XCUIElement { get }
    var myLocationButton: XCUIElement { get }
    var manualInputButton: XCUIElement { get }
    var chooseOnMapButton: XCUIElement { get }

    func closeSettingsView()

    init(app: XCUIApplication)
}

final class SettingsViewPageObject: SettingsViewPageObjectProtocol {
    var app: XCUIApplication

    var closeButton: XCUIElement { return app.buttons["xmark"] }

    var myLocationButton: XCUIElement { return app.buttons["Мое местоположение"] }

    var manualInputButton: XCUIElement { return app.buttons["Ручной ввод"] }

    var chooseOnMapButton: XCUIElement { return app.buttons["Выбор на карте"] }

    func closeSettingsView() {
        closeButton.tap()
    }

    init(app: XCUIApplication) {
        self.app = app
    }
}
