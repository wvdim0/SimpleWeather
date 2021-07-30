//
//  FavoritesViewPresenterUnitTests.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import XCTest

@testable import Simple_Weather

final class FavoritesViewPresenterUnitTests: XCTestCase {
    private let favoritesViewMock = FavoritesViewControllerMock()
    private let networkManagerMock = NetworkManagerMock()
    private let coreDataManagerMock = CoreDataManagerMock()
    private let routerMock = RouterMock()

    private lazy var favoritesViewPresenter = FavoritesViewPresenter(favoritesView: favoritesViewMock,
                                                                     viewPresenter: nil,
                                                                     networkManager: networkManagerMock,
                                                                     coreDataManager: coreDataManagerMock,
                                                                     router: routerMock)

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        coreDataManagerMock.favoritePlaces.removeAll()

        favoritesViewMock.numberOfLoadingAnimationStops = 0
    }

    func testThatFavoritePlacesArrayIsNotEmptyAfterFirstAddingNewFavoritePlace() {
        // act
        favoritesViewPresenter.addFavoritePlaceToCoreData(with: "Moscow")

        let favoritePlaces = favoritesViewPresenter.getFavoritePlacesFromCoreData()

        // assert
        XCTAssertFalse(favoritePlaces.isEmpty)
    }

    func testThatNumberOfFavoritePlacesHasDecreasedByOneAfterDeletingFavoritePlace() {
        // arrange
        let expectedNumberOfFavoritePlaces = 0

        favoritesViewPresenter.addFavoritePlaceToCoreData(with: "Moscow")

        // act
        favoritesViewPresenter.deletePlaceFromCoreData(at: 0)

        let favoritePlaces = favoritesViewPresenter.getFavoritePlacesFromCoreData()

        // assert
        XCTAssertEqual(expectedNumberOfFavoritePlaces, favoritePlaces.count)
    }

    func testThatFavoritesViewStopsLoadingAnimationWhenTryingToAddEmptyStringToCoreData() {
        // arrange
        let expectedNumberOfLoadingAnimationStops = 1

        // act
        favoritesViewPresenter.addFavoritePlaceToCoreData(with: "")

        // assert
        XCTAssertEqual(expectedNumberOfLoadingAnimationStops, favoritesViewMock.numberOfLoadingAnimationStops)
    }
}
