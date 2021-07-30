//
//  GeocoderMock.swift
//  SimpleWeatherUnitTests
//
//  Created by Вадим Аписов on 28.07.2021.
//

import Foundation

final class GeocoderMock: GeocoderProtocol {
    func convertLocationToAddress(_ location: Location, completion: @escaping GeocoderHandler) {
        completion("Россия, Москва\nМосква, Никольский переулок, 3")
    }
}
