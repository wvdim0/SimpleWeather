//
//  ViewPageObject.swift
//  SimpleWeatherUITests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import Foundation
import XCTest

protocol ViewPageObjectProtocol {
    var app: XCUIApplication { get }

    var favoritesButton: XCUIElement { get }
    var settingsButton: XCUIElement { get }
    var tableView: XCUIElement { get }
    var rejectLocationButton: XCUIElement { get }
    var okAlertButton: XCUIElement { get }

    func displaySettingsView() -> SettingsViewPageObject

    init(app: XCUIApplication)
}

final class ViewPageObject: ViewPageObjectProtocol {
    var app: XCUIApplication

    var favoritesButton: XCUIElement { return app.navigationBars.buttons.element(matching: .button,
                                                                                 identifier: "favoritesButton")}

    var settingsButton: XCUIElement { return app.navigationBars.buttons.element(matching: .button,
                                                                                identifier: "settingsButton") }

    var tableView: XCUIElement { return app.tables.element(boundBy: 0) }

    var rejectLocationButton: XCUIElement { return app.alerts.buttons.element(boundBy: 2) }

    var okAlertButton: XCUIElement { return app.alerts.buttons["OK"] }

    func displaySettingsView() -> SettingsViewPageObject {
        settingsButton.tap()

        return SettingsViewPageObject(app: app)
    }

    init(app: XCUIApplication) {
        self.app = app
    }
}
