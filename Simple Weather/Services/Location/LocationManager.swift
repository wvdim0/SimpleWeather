//
//  LocationManager.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 18.07.2021.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func getUserLocation(completion: @escaping LocationHandler)
}

final class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {
    // MARK: - Properties

    private var completion: LocationHandler?

    private let clLocationManager = CLLocationManager()

    // MARK: - LocationManagerProtocol conforming methods

    func getUserLocation(completion: @escaping LocationHandler) {
        self.completion = completion

        clLocationManager.delegate = self

        checkLocationServices()
    }

    // MARK: - Private methods

    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAutorization()
        } else {
            clLocationManager.delegate = nil

            completion?(.failure(CustomError(description: Constants.ErrorMesages.locationServicesAreDisabled)))
        }
    }

    private func checkLocationAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            clLocationManager.requestLocation()
        case .denied:
            clLocationManager.delegate = nil

            completion?(.failure(CustomError(description: Constants.ErrorMesages.noAccessToUserLocation)))
        case .notDetermined:
            clLocationManager.requestWhenInUseAuthorization()
        default:
            clLocationManager.delegate = nil

            completion?(.failure(CustomError(description: Constants.ErrorMesages.locationError)))
        }
    }

    // MARK: - CLLocationManagerDelegate methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            clLocationManager.delegate = nil

            completion?(.failure(CustomError(description: Constants.ErrorMesages.locationError)))

            return
        }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        clLocationManager.delegate = nil

        completion?(.success(Location(latitude: latitude, longitude: longitude)))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        clLocationManager.delegate = nil

        completion?(.failure(CustomError(description: Constants.ErrorMesages.locationError)))
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationServices()
    }

    // MARK: - Init

    override init() {
        super.init()

        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}
