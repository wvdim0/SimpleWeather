//
//  Constants.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 03.06.2021.
//

import UIKit

enum Constants {
    enum APIKeys {
        static let owmAPIKey = "3487acf8c05389babc61aeb9a4a3cd4f"
    }

    enum URL {
        static let owmWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
        static let owmOneCallURL = "https://api.openweathermap.org/data/2.5/onecall"
        static let imageURL = "https://i.postimg.cc/CLXfqnnM/wvdim0.jpg"
    }

    enum ErrorMesages {
        static let weatherError = "Не удалось получить информацию о погоде"
        static let placeNotFound = "Место не найдено"
        static let emptyTitle = "Название места не может быть пустым"
        static let locationError = "Не удалось определить Ваше местоположение"
        static let locationServicesAreDisabled = "Службы геолокации отключены"
        static let noAccessToUserLocation = "Приложение не имеет доступа к Вашему местоположению"
        static let noInternetConnection = "Отсутствует соединение с интернетом"
        static let placeAlreadyExists = "Место уже существует в \"Избранном\""
    }

    enum Colors {
        static let mainBackgroundColor = UIColor(red: 64 / 255, green: 72 / 255, blue: 88 / 255, alpha: 1)
        static let lightColor = UIColor(red: 80 / 255, green: 87 / 255, blue: 100 / 255, alpha: 1)
        static let middleColor = UIColor(red: 59 / 255, green: 63 / 255, blue: 71 / 255, alpha: 1)
        static let darkColor = UIColor(red: 36 / 255, green: 40 / 255, blue: 47 / 255, alpha: 1)
    }

    enum UDefValues {
        static let myLocation = "Мое местоположение"
        static let unknownPlace = "Неизвестное место"
    }

    enum Locations {
        static let moscow = Location(latitude: 55.757997, longitude: 37.615901)
    }
}
