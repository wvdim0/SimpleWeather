//
//  FavoritesViewPresenter.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 22.07.2021.
//

import Foundation

protocol FavoritesViewPresenterProtocol {
    func getFavoritePlacesFromCoreData() -> [String]
    func addFavoritePlaceToCoreData(with name: String?)
    func deletePlaceFromCoreData(at index: Int)
    func getWeatherForSelectedRow(at index: Int)
}

final class FavoritesViewPresenter: FavoritesViewPresenterProtocol {
    // MARK: - Properties

    weak private var favoritesView: FavoritesViewProtocol?
    weak private var viewPresenter: ViewPresenterProtocol?

    private var networkManager: NetworkManagerProtocol

    private let coreDataManager: CoreDataManagerProtocol
    private let router: RouterProtocol

    // MARK: - FavoritesViewPresenterProtocol conforming methods

    func addFavoritePlaceToCoreData(with name: String?) {
        favoritesView?.startLoadingAnimation()

        if let name = name {
            switch name {
            case "":
                favoritesView?.stopLoadingAnimation()
                favoritesView?.displayErrorAlert(with: Constants.ErrorMesages.emptyTitle)
            default:
                networkManager.performRequest(for: .city(name), completion: getNetworkManagerCompletion())
            }
        } else {
            favoritesView?.stopLoadingAnimation()
            favoritesView?.displayErrorAlert(with: Constants.ErrorMesages.weatherError)
        }
    }

    func getFavoritePlacesFromCoreData() -> [String] {
        let favoritePlaces = coreDataManager.getFavoritePlaces()

        if favoritePlaces.isEmpty {
            favoritesView?.displayEmptyTableMessage()
        } else {
            favoritesView?.hideEmptyTableMessage()
        }

        return favoritePlaces
    }

    func deletePlaceFromCoreData(at index: Int) {
        coreDataManager.deleteFavoritePlace(at: index)
        favoritesView?.deleteFavoritePlace(at: index)
    }

    func getWeatherForSelectedRow(at index: Int) {
        let favoritePlaces = coreDataManager.getFavoritePlaces()
        let name = favoritePlaces[index]

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.35) { [weak self] in
            guard let self = self else { return }

            self.viewPresenter?.getWeather(for: .favoritePlace(name))
        }
    }

    // MARK: - Private methods

    private func getNetworkManagerCompletion() -> WeatherHandler {
        let completion: WeatherHandler = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let resultWeather):
                let favoritePlaces = self.coreDataManager.getFavoritePlaces()

                if favoritePlaces.count >= 1 {
                    for (index, place) in favoritePlaces.enumerated() {
                        if resultWeather.city == place {
                            self.favoritesView?.displayErrorAlert(with: Constants.ErrorMesages.placeAlreadyExists)

                            break
                        } else if index == favoritePlaces.count - 1 {
                            self.coreDataManager.addFavoritePlace(with: resultWeather.city)
                            self.favoritesView?.addFavoritePlace()
                        }
                    }
                } else {
                    self.coreDataManager.addFavoritePlace(with: resultWeather.city)
                    self.favoritesView?.addFavoritePlace()
                }
            case .failure(let error):
                self.favoritesView?.displayErrorAlert(with: error.description)
            }

            self.favoritesView?.stopLoadingAnimation()
        }

        return completion
    }

    // MARK: - Init

    init(favoritesView: FavoritesViewProtocol, viewPresenter: ViewPresenterProtocol?,
         networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol, router: RouterProtocol) {
        self.favoritesView = favoritesView
        self.viewPresenter = viewPresenter
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
        self.router = router
    }
}
