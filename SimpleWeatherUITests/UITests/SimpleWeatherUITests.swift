//
//  SimpleWeatherUITests.swift
//  SimpleWeatherUITests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import XCTest

@testable import Simple_Weather

class SimpleWeatherUITests: XCTestCase {
    var app: XCUIApplication!
    var view: ViewPageObjectProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

        view = ViewPageObject(app: app)
    }

    func testThatViewDisplaysCorrectlyWhenAppIsLoaded() {
        if view.rejectLocationButton.exists {
            view.rejectLocationButton.tap()
        }

        if view.okAlertButton.exists {
            view.okAlertButton.tap()
        }

        XCTAssertTrue(view.favoritesButton.exists)
        XCTAssertTrue(view.settingsButton.exists)
        XCTAssertTrue(view.tableView.exists)
    }

    func testThatSettingsViewOpensAndClosesCorrectly() {
        if view.rejectLocationButton.exists {
            view.rejectLocationButton.tap()
        }

        if view.okAlertButton.exists {
            view.okAlertButton.tap()
        }

        let settingsView = view.displaySettingsView()

        XCTAssertTrue(settingsView.closeButton.exists)
        XCTAssertTrue(settingsView.myLocationButton.exists)
        XCTAssertTrue(settingsView.manualInputButton.exists)
        XCTAssertTrue(settingsView.chooseOnMapButton.exists)

        settingsView.closeSettingsView()

        XCTAssertFalse(settingsView.closeButton.exists)
        XCTAssertFalse(settingsView.myLocationButton.exists)
        XCTAssertFalse(settingsView.manualInputButton.exists)
        XCTAssertFalse(settingsView.chooseOnMapButton.exists)
    }
}
