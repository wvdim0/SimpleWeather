//
//  Geocoder.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 19.07.2021.
//

import Foundation
import CoreLocation

protocol GeocoderProtocol {
    func convertLocationToAddress(_ location: Location, completion: @escaping GeocoderHandler)
}

final class Geocoder: CLGeocoder, GeocoderProtocol {
    // MARK: - Properties

    private let clGeocoder = CLGeocoder()

    // MARK: - GeocoderProtocol conforming methods

    func convertLocationToAddress(_ location: Location, completion: @escaping GeocoderHandler) {
        clGeocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude,
                                                     longitude: location.longitude)) { placemarks, error in
            if error == nil, let placemark = placemarks?.last {
                let country = placemark.country ?? ""
                let region = placemark.administrativeArea ?? ""
                let locality = placemark.locality ?? ""
                let street = placemark.thoroughfare ?? ""
                let building = placemark.subThoroughfare ?? ""

                if !country.isEmpty, !region.isEmpty, !locality.isEmpty, !street.isEmpty, !building.isEmpty {
                    completion("\(country), \(region),\n\(locality), \(street), \(building)")
                } else if !country.isEmpty, !region.isEmpty, !locality.isEmpty, !street.isEmpty {
                    completion("\(country), \(region),\n\(locality), \(street)")
                } else if !country.isEmpty, !region.isEmpty, !locality.isEmpty {
                    completion("\(country), \(region), \(locality)")
                } else if !country.isEmpty, !region.isEmpty {
                    completion("\(country), \(region)")
                } else if !country.isEmpty {
                    completion("\(country)")
                } else {
                    completion("Неизвестный адрес")
                }
            } else {
                completion("Неизвестный адрес")
            }
        }
    }
}
