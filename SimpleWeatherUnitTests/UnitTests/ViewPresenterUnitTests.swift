//
//  ViewPresenterUnitTests.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//
//  swiftlint:disable identifier_name

import XCTest

@testable import Simple_Weather

final class ViewPresenterUnitTests: XCTestCase {
    private let viewMock = ViewControllerMock()
    private let networkManagerMock = NetworkManagerMock()
    private let locationManagerMock = LocationManagerMock()
    private let routerMock = RouterMock()

    private lazy var viewPresenter = ViewPresenter(view: viewMock, networkManager: networkManagerMock,
                                                   locationManager: locationManagerMock, router: routerMock)

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        networkManagerMock.numberOfRequestsForCity = 0
        networkManagerMock.numberOfRequestsForCoordinates = 0

        viewMock.numberOfDisplayedErrorAlerts = 0
        viewMock.numberOfDisplayedMapViewControllers = 0
        viewMock.numberOfInterfaceUpdates = 0

        UDef.currentPlaceLatitude = 0.0
        UDef.currentPlaceLongitude = 0.0
    }

    func testThatNetworkManagerPerformsRequestWhenCityIsValid() {
        // arrange
        let expectedNumberOfRequestsForCity = 1

        // act
        viewPresenter.getWeather(for: .city("Moscow"))

        // assert
        XCTAssertEqual(expectedNumberOfRequestsForCity, networkManagerMock.numberOfRequestsForCity)
    }

    func testThatViewUpdatesInterfaceWhenCityIsValidAntNetworkManagerPassesSuccessToCompletion() {
        // arrange
        let expectedNumberOfInterfaceUpdates = 1

        // act
        viewPresenter.getWeather(for: .city("London"))

        // assert
        XCTAssertEqual(expectedNumberOfInterfaceUpdates, viewMock.numberOfInterfaceUpdates)
    }

    func testThatViewDisplaysErrorAlertWhenCityIsNil() {
        // arrange
        let expectedNumberOfDisplayedErrorAlerts = 1

        // act
        viewPresenter.getWeather(for: .city(nil))

        // assert
        XCTAssertEqual(expectedNumberOfDisplayedErrorAlerts, viewMock.numberOfDisplayedErrorAlerts)
    }

    func testThatViewDisplaysMapViewController() {
        // arrange
        let expectedNumberOfDisplayedMapViewControllers = 1

        // act
        viewPresenter.displayMapViewController()

        // assert
        XCTAssertEqual(expectedNumberOfDisplayedMapViewControllers, viewMock.numberOfDisplayedMapViewControllers)
    }

    func testThatNetworkManagerPerformsRequestWhenCurrentPlaceCoordinatesIsNotEqualToZero() {
        // arrange
        let expectedNumberOfRequestsForCoordinates = 1

        UDef.currentPlaceLatitude = 1.1
        UDef.currentPlaceLongitude = 2.2

        // act
        viewPresenter.getWeather(for: .currentPlace)

        // assert
        XCTAssertEqual(expectedNumberOfRequestsForCoordinates, networkManagerMock.numberOfRequestsForCoordinates)
    }
}
