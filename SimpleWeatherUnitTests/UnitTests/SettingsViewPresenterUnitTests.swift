//
//  SettingsViewPresenterUnitTests.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 29.07.2021.
//
//  swiftlint:disable identifier_name

import XCTest

@testable import Simple_Weather

final class SettingsViewPresenterUnitTests: XCTestCase {
    private let settingsViewMock = SettingsViewMock()
    private let viewPresenterMock = ViewPresenterMock()
    private let networkManagerMock = NetworkManagerMock()
    private let routerMock = RouterMock()

    private lazy var settingsViewPresenter = SettingsViewPresenter(settingsView: settingsViewMock,
                                                                   viewPresenter: viewPresenterMock,
                                                                   networkManager: networkManagerMock,
                                                                   router: routerMock)

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        viewPresenterMock.numberOfDisplayedManualInputAlerts = 0
    }

    func testThatViewPresenterDisplaysManualInputAlert() {
        // arrange
        let expectedNumberOfDisplayedManualInputAlerts = 1

        // act
        settingsViewPresenter.displayManualInputAlert()

        // assert
        XCTAssertEqual(expectedNumberOfDisplayedManualInputAlerts, viewPresenterMock.numberOfDisplayedManualInputAlerts)
    }
}
