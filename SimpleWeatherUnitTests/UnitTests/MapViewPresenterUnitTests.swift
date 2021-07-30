//
//  MapViewPresenterUnitTests.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 29.07.2021.
//

import XCTest

@testable import Simple_Weather

final class MapViewPresenterUnitTests: XCTestCase {
    private let mapViewMock = MapViewControllerMock()
    private let viewPresenterMock = ViewPresenterMock()
    private let locationManagerMock = LocationManagerMock()
    private let geocoderMock = GeocoderMock()
    private let routerMock = RouterMock()

    private lazy var mapViewPresenter = MapViewPresenter(mapView: mapViewMock,
                                                         viewPresenter: viewPresenterMock,
                                                         locationManager: locationManagerMock,
                                                         geocoder: geocoderMock,
                                                         router: routerMock)

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        mapViewMock.numberOfDisplayedLocations = 0
        mapViewMock.numberOfDisplayedAddresses = 0

        viewPresenterMock.numberOfWeatherRequests = 0
    }

    func testThatMapViewDisplaysLocationWhenLocationManagerPassesCoordinatesToCompletion() {
        // arrange
        let expectedNumberOfDisplayedLocations = 1

        // act
        mapViewPresenter.getUserLocation()

        // assert
        XCTAssertEqual(expectedNumberOfDisplayedLocations, mapViewMock.numberOfDisplayedLocations)
    }

    func testThatMapViewDisplaysAddressWhenCoordinatesIsConvertedToAddressString() {
        // arrange
        let expectedNumberDisplayedAddresses = 1

        // act
        mapViewPresenter.convertLocationToAddress(Location(latitude: 0.0, longitude: 0.0))

        // assert
        XCTAssertEqual(expectedNumberDisplayedAddresses, mapViewMock.numberOfDisplayedAddresses)
    }

    func testThatMapViewDisplaysLocationWhenOKButtonTappedInErrorAlert() {
        // arrange
        let expectedNumberOfDisplayedLocations = 1

        // act
        mapViewPresenter.errorAlertOKButtonTapped()

        // assert
        XCTAssertEqual(expectedNumberOfDisplayedLocations, mapViewMock.numberOfDisplayedLocations)
    }

    func testThatViewPresenterRequestsWeather() {
        // arrange
        let expectedNumberOfWeatherRequests = 1

        // act
        mapViewPresenter.getWeather(for: nil, longitude: nil)

        // assert
        XCTAssertEqual(expectedNumberOfWeatherRequests, viewPresenterMock.numberOfWeatherRequests)
    }
}
