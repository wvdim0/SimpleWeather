//
//  AssemblyBuilder.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 25.07.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func getMainModule(router: RouterProtocol) -> UIViewController
    func getSettingsModule(router: RouterProtocol) -> UIViewController
    func getFavoritesModule(router: RouterProtocol) -> UIViewController
    func getMapModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Properties

    private var viewPresenter: ViewPresenterProtocol?

    // MARK: - AssemblyBuilderProtocol conforming methods

    func getMainModule(router: RouterProtocol) -> UIViewController {
        let viewController = ViewController()
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        let viewPresenter = ViewPresenter(view: viewController,
                                          networkManager: networkManager,
                                          locationManager: locationManager,
                                          router: router)

        viewController.viewPresenter = viewPresenter
        self.viewPresenter = viewPresenter

        return viewController
    }

    func getSettingsModule(router: RouterProtocol) -> UIViewController {
        let settingsViewController = SettingsViewController()
        let networkManager = NetworkManager()
        let settingsViewPresenter = SettingsViewPresenter(settingsView: settingsViewController,
                                                          viewPresenter: viewPresenter,
                                                          networkManager: networkManager,
                                                          router: router)

        settingsViewController.settingsViewPresenter = settingsViewPresenter

        return settingsViewController
    }

    func getFavoritesModule(router: RouterProtocol) -> UIViewController {
        let favoritesViewController = FavoritesViewController()
        let networkManager = NetworkManager()
        let coreDataManager = CoreDataManager()
        let favoritesViewPresenter = FavoritesViewPresenter(favoritesView: favoritesViewController,
                                                            viewPresenter: viewPresenter,
                                                            networkManager: networkManager,
                                                            coreDataManager: coreDataManager,
                                                            router: router)

        favoritesViewController.favoritesViewPresenter = favoritesViewPresenter

        return favoritesViewController
    }

    func getMapModule(router: RouterProtocol) -> UIViewController {
        let mapViewController = MapViewController()
        let geocoder = Geocoder()
        let locationManager = LocationManager()
        let mapViewPresenter = MapViewPresenter(mapView: mapViewController,
                                                viewPresenter: viewPresenter,
                                                locationManager: locationManager,
                                                geocoder: geocoder,
                                                router: router)

        mapViewController.mapViewPresenter = mapViewPresenter

        return mapViewController
    }
}
