//
//  MapViewPresenter.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 19.07.2021.
//

import Foundation

protocol MapViewPresenterProtocol {
    func getUserLocation()
    func convertLocationToAddress(_ location: Location)
    func errorAlertOKButtonTapped()
    func getWeather(for latitude: Double?, longitude: Double?)
    func popMapViewController()
}

final class MapViewPresenter: MapViewPresenterProtocol {
    // MARK: - Properties

    weak private var mapView: MapViewProtocol?
    weak private var viewPresenter: ViewPresenterProtocol?

    private var locationManager: LocationManagerProtocol
    private var geocoder: GeocoderProtocol
    private let router: RouterProtocol

    // MARK: - MapViewPresenterProtocol conforming methods

    func getUserLocation() {
        mapView?.startLoadingAnimation()

        locationManager.getUserLocation { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let location):
                self.mapView?.stopLoadingAnimation()
                self.mapView?.showUserLocationPlacemark()
                self.mapView?.displayLocation(location)
            case .failure(let error):
                self.mapView?.stopLoadingAnimation()
                self.mapView?.displayErrorAlert(with: error.description)
            }
        }
    }

    func convertLocationToAddress(_ location: Location) {
        geocoder.convertLocationToAddress(location) { [weak self] address in
            guard let self = self else { return }

            self.mapView?.displayAddress(address)
        }
    }

    func errorAlertOKButtonTapped() {
        if (UDef.currentPlaceLatitude != 0.0) && (UDef.currentPlaceLongitude != 0.0) {
            mapView?.displayLocation(Location(latitude: UDef.currentPlaceLatitude,
                                              longitude: UDef.currentPlaceLongitude))
        } else {
            mapView?.displayLocation(Constants.Locations.moscow)
        }
    }

    func popMapViewController() {
        router.popMapViewController()
    }

    func getWeather(for latitude: Double?, longitude: Double?) {
        viewPresenter?.getWeather(for: .coordinates((latitude: latitude, longitude: longitude)))
    }

    // MARK: - Init

    init(mapView: MapViewProtocol, viewPresenter: ViewPresenterProtocol?,
         locationManager: LocationManagerProtocol, geocoder: GeocoderProtocol, router: RouterProtocol) {
        self.mapView = mapView
        self.viewPresenter = viewPresenter
        self.locationManager = locationManager
        self.geocoder = geocoder
        self.router = router
    }
}
