//
//  UDef.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 21.07.2021.
//

import Foundation

enum UDef {
    static var defaultPlace: String? {
        get {
            return UserDefaults.standard.string(forKey: "defaultPlace")
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: "defaultPlace")
        }
    }

    static var defaultPlaceCache: String? {
        get {
            return UserDefaults.standard.string(forKey: "defaultPlaceCache")
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: "defaultPlaceCache")
        }
    }

    static var defaultPlaceLatitude: Double {
        get {
            return UserDefaults.standard.double(forKey: "defaultPlaceLatitude")
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: "defaultPlaceLatitude")
        }
    }

    static var defaultPlaceLongitude: Double {
        get {
            return UserDefaults.standard.double(forKey: "defaultPlaceLongitude")
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: "defaultPlaceLongitude")
        }
    }

    static var currentPlaceLatitude: Double {
        get {
            return UserDefaults.standard.double(forKey: "currentPlaceLatitude")
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentPlaceLatitude")
        }
    }

    static var currentPlaceLongitude: Double {
        get {
            return UserDefaults.standard.double(forKey: "currentPlaceLongitude")
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentPlaceLongitude")
        }
    }
}
