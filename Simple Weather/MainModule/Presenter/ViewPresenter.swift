//
//  ViewPresenter.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 03.06.2021.
//

import UIKit

protocol ViewPresenterProtocol: class {
    func getWeather(for requestType: RequestType)
    func getWeather(for placeType: PlaceType)
    func displayMapViewController()
    func displayManualInputAlert()
    func getFavoritesViewController() -> UIViewController
    func getSettingsViewController() -> UIViewController
    func pushMapViewController()
}

final class ViewPresenter: ViewPresenterProtocol {
    // MARK: - Properties

    weak private var view: ViewProtocol?

    private var networkManager: NetworkManagerProtocol

    private let locationManager: LocationManagerProtocol
    private let router: RouterProtocol

    // MARK: - ViewPresenterProtocol conforming methods

    func getWeather(for requestType: RequestType) {
        if let view = view, !view.isLoadingAnimationInProcess {
            view.startLoadingAnimation()
        }

        switch requestType {
        case .city(let city):
            if let city = city {
                switch city {
                case "":
                    view?.stopLoadingAnimation()
                    view?.displayErrorAlert(with: Constants.ErrorMesages.emptyTitle)
                default:
                    UDef.defaultPlaceCache = UDef.defaultPlace
                    UDef.defaultPlace = nil

                    networkManager.performRequest(for: .city(city), completion: getNetworkManagerCompletion())
                }
            } else {
                view?.stopLoadingAnimation()
                view?.displayErrorAlert(with: Constants.ErrorMesages.weatherError)
            }
        case .coordinates(let (latitude, longitude)):
            if let latitude = latitude,
               let longitude = longitude {
                UDef.defaultPlaceCache = UDef.defaultPlace
                UDef.defaultPlace = nil

                networkManager.performRequest(for: .coordinates((latitude: latitude, longitude: longitude)),
                                              completion: getNetworkManagerCompletion())
            } else {
                view?.stopLoadingAnimation()
                view?.displayErrorAlert(with: Constants.ErrorMesages.weatherError)
            }
        case .location:
            UDef.defaultPlace = Constants.UDefValues.myLocation

            locationManager.getUserLocation { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let location):
                    self.networkManager.performRequest(for: .coordinates((latitude: location.latitude,
                                                                          longitude: location.longitude)),
                                                       completion: self.getNetworkManagerCompletion())
                case .failure(let error):
                    self.view?.stopLoadingAnimation()
                    self.view?.displayErrorAlert(with: error.description)
                }
            }
        }
    }

    func getWeather(for placeType: PlaceType) {
        if let view = view, !view.isLoadingAnimationInProcess {
            view.startLoadingAnimation()
        }

        switch placeType {
        case .favoritePlace(let name):
            networkManager.performRequest(for: .city(name), completion: getNetworkManagerCompletion())
        case .currentPlace:
            if (UDef.currentPlaceLatitude != 0.0) && (UDef.currentPlaceLongitude != 0.0) {
                networkManager.performRequest(for: .coordinates((latitude: UDef.currentPlaceLatitude,
                                                                 longitude: UDef.currentPlaceLongitude)),
                                              completion: getNetworkManagerCompletion())
            } else {
                let latitude = Constants.Locations.moscow.latitude
                let longitude = Constants.Locations.moscow.longitude

                networkManager.performRequest(for: .coordinates((latitude: latitude, longitude: longitude)),
                                              completion: getNetworkManagerCompletion())
            }
        case .defaultPlace:
            if (UDef.defaultPlace == nil) || (UDef.defaultPlace == Constants.UDefValues.myLocation) {
                getWeather(for: .location)
            } else {
                getWeather(for: .coordinates((latitude: UDef.defaultPlaceLatitude,
                                              longitude: UDef.defaultPlaceLongitude)))
            }
        }
    }

    func displayMapViewController() {
        view?.displayMapViewController()
    }

    func displayManualInputAlert() {
        view?.displayManualInputAlert()
    }

    func getFavoritesViewController() -> UIViewController {
        let favoritesViewController = router.getFavoritesViewController()

        return favoritesViewController
    }

    func getSettingsViewController() -> UIViewController {
        let settingsViewController = router.getSettingsViewController()

        return settingsViewController
    }

    func pushMapViewController() {
        router.pushMapViewController()
    }

    // MARK: - Private methods

    private func getNetworkManagerCompletion() -> WeatherHandler {
        let completion: WeatherHandler = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let resultWeather):
                if UDef.defaultPlace == nil {
                    switch resultWeather.city {
                    case "":
                        UDef.defaultPlace = Constants.UDefValues.unknownPlace
                    default:
                        UDef.defaultPlace = resultWeather.city
                    }

                    UDef.defaultPlaceLatitude = resultWeather.latitude
                    UDef.defaultPlaceLongitude = resultWeather.longitude
                }

                UDef.currentPlaceLatitude = resultWeather.latitude
                UDef.currentPlaceLongitude = resultWeather.longitude

                self.view?.stopLoadingAnimation()
                self.view?.updateInterface(with: resultWeather)
            case.failure(let error):
                if UDef.defaultPlace == nil {
                    UDef.defaultPlace = UDef.defaultPlaceCache
                }

                self.view?.stopLoadingAnimation()
                self.view?.displayErrorAlert(with: error.description)
            }
        }

        return completion
    }

    // MARK: - Init

    init(view: ViewProtocol, networkManager: NetworkManagerProtocol, locationManager: LocationManagerProtocol,
         router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.locationManager = locationManager
        self.router = router
    }
}
