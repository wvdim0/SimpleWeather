//
//  Enums.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 20.07.2021.
//

import Foundation

enum RequestType {
    case city(_ name: String?)
    case coordinates((latitude: Double?, longitude: Double?))
    case location
}

enum PlaceType {
    case favoritePlace(_ name: String)
    case currentPlace
    case defaultPlace
}

enum NetworkRequestType {
    case city(_ name: String)
    case coordinates((latitude: Double, longitude: Double))
}
