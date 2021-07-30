//
//  ResultWeather.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 07.07.2021.
//

import Foundation

struct ResultWeather {
    let city: String
    let latitude: Double
    let longitude: Double
    let current: ResultCurrentWeather
    let daily: ResultDailyWeather

    init(weatherLocation: WeatherLocation, weather: Weather) {
        city = weatherLocation.city
        latitude = weatherLocation.coordinates.latitude
        longitude = weatherLocation.coordinates.longitude
        current = ResultCurrentWeather(currentWeather: weather.current,
                                       timeZoneOffset: weatherLocation.timeZoneOffset)
        daily = ResultDailyWeather(intermediateDailyWeather: weather.daily,
                                   timeZoneOffset: weatherLocation.timeZoneOffset)
    }
}

struct ResultCurrentWeather {
    private let conditionCode: Int
    private let intermediateTemperature: Double
    private let intermediateFeelsLikeTemperature: Double
    private let intermediatePressure: Double
    private let intermediateHumidity: Int
    private let intermediateDescription: String
    private let windSpeed: Double
    private let windDegrees: Int
    private let dateTime: Double
    private let timeZoneOffset: Int

    private var dateComponents: DateComponents {
        let date = Date(timeIntervalSince1970: dateTime)

        var calendar = Calendar(identifier: .gregorian)

        if let timeZone = TimeZone(secondsFromGMT: timeZoneOffset) {
            calendar.timeZone = timeZone
        }

        let dateComponents = calendar.dateComponents([.hour], from: date)

        return dateComponents
    }

    private var isItNight: Bool {
        guard let hour = dateComponents.hour else { return false }

        if hour >= 22 || hour <= 5 {
            return true
        } else {
            return false
        }
    }

    var weatherConditionImageName: String {
        switch conditionCode {
        case 200...232: return "Thunderstorm"
        case 300...321: return "ShowerRain"
        case 500...504:
            if isItNight {
                return "RainNight"
            } else {
                return "RainDay"
            }
        case 511:       return "Snow"
        case 520...531: return "ShowerRain"
        case 600...622: return "Snow"
        case 701...781: return "Mist"
        case 800:
            if isItNight {
                return "ClearSkyNight"
            } else {
                return "ClearSkyDay"
            }
        case 801:
            if isItNight {
                return "FewCloudsNight"
            } else {
                return "FewCloudsDay"
            }
        case 802:       return "Clouds"
        case 803...804: return "BrokenClouds"
        default:        return "questionmark.circle"
        }
    }

    var temperature: String {
        let temperature = String(format: "%.0f", round(intermediateTemperature))

        switch temperature {
        case "-0": return "0°"
        default:   return temperature + "°"
        }
    }

    var description: String {
        return intermediateDescription.prefix(1).capitalized + intermediateDescription.dropFirst()
    }

    var feelsLikeTemperature: String {
        let feelsLikeTemperature = String(format: "%.0f", round(intermediateFeelsLikeTemperature))

        switch feelsLikeTemperature {
        case "-0": return "Ощущается как 0°"
        default:   return "Ощущается как \(feelsLikeTemperature)°"
        }
    }

    var pressure: String {
        return "Давление\n\(Int(round(intermediatePressure * 0.7501))) мм.рт.ст."
    }

    var humidity: String {
        return "Влажность\n\(intermediateHumidity)%"
    }

    var wind: String {
        let resultWindSpeed = Int(round(windSpeed))
        var resultWindDirection = ""
        let windDirections = ["С", "С", "СВ", "В", "ЮВ", "Ю", "ЮЗ", "З", "СЗ"]
        let degreesRanges = [338...360, 0...22, 23...67, 68...112, 113...157,
                             158...202, 203...247, 248...292, 293...337]

        for (index, degreesRange) in degreesRanges.enumerated() {
            if degreesRange.contains(windDegrees) {
                resultWindDirection = windDirections[index]

                break
            }
        }

        return "Ветер\n\(resultWindSpeed) м/с, \(resultWindDirection)"
    }

    init(currentWeather: CurrentWeather, timeZoneOffset: Int) {
        conditionCode = currentWeather.details[0].id
        intermediateTemperature = currentWeather.temperature
        intermediateFeelsLikeTemperature = currentWeather.feelsLikeTemperature
        intermediatePressure = currentWeather.pressure
        intermediateHumidity = currentWeather.humidity
        intermediateDescription = currentWeather.details[0].description
        windSpeed = currentWeather.windSpeed
        windDegrees = currentWeather.windDegrees
        dateTime = currentWeather.dateTime
        self.timeZoneOffset = timeZoneOffset
    }
}

struct ResultDailyWeather {
    private let intermediateDailyWeather: [DailyWeather]
    private let timeZoneOffset: Int

    private var datesComponents: [DateComponents] {
        var dates = [Date]()

        for oneDayWeather in intermediateDailyWeather {
            let date = Date(timeIntervalSince1970: oneDayWeather.dateTime)

            dates.append(date)
        }

        var calendar = Calendar(identifier: .gregorian)

        if let timeZone = TimeZone(secondsFromGMT: timeZoneOffset) {
            calendar.timeZone = timeZone
        }

        var datesComponents = [DateComponents]()

        for date in dates {
            let dateComponents = calendar.dateComponents([.day, .month, .weekday], from: date)

            datesComponents.append(dateComponents)
        }

        return datesComponents
    }

    var dates: [String] {
        var dates = [String]()

        for dateComponents in datesComponents {
            guard let day = dateComponents.day,
                  let month = dateComponents.month else { dates.append("--"); continue }

            switch month {
            case 1:  dates.append("\(day) января")
            case 2:  dates.append("\(day) февраля")
            case 3:  dates.append("\(day) марта")
            case 4:  dates.append("\(day) апреля")
            case 5:  dates.append("\(day) мая")
            case 6:  dates.append("\(day) июня")
            case 7:  dates.append("\(day) июля")
            case 8:  dates.append("\(day) августа")
            case 9:  dates.append("\(day) сентября")
            case 10: dates.append("\(day) октября")
            case 11: dates.append("\(day) ноября")
            case 12: dates.append("\(day) декабря")
            default: dates.append("--")
            }
        }

        return dates
    }

    var weekdays: [String] {
        var weekdays = [String]()

        for (index, dateComponents) in datesComponents.enumerated() {
            switch index {
            case 0: weekdays.append("Сегодня")
            case 1: weekdays.append("Завтра")
            default:
                guard let weekday = dateComponents.weekday else { weekdays.append("--"); continue }

                switch weekday {
                case 1:  weekdays.append("Воскресенье")
                case 2:  weekdays.append("Понедельник")
                case 3:  weekdays.append("Вторник")
                case 4:  weekdays.append("Среда")
                case 5:  weekdays.append("Четверг")
                case 6:  weekdays.append("Пятница")
                case 7:  weekdays.append("Суббота")
                default: weekdays.append("--")
                }
            }
        }

        return weekdays
    }

    var weatherConditionImageNames: [String] {
        var weatherConditionImageNames = [String]()

        for oneDayWeather in intermediateDailyWeather {
            switch oneDayWeather.details[0].id {
            case 200...232: weatherConditionImageNames.append("Thunderstorm")
            case 300...321: weatherConditionImageNames.append("ShowerRain")
            case 500...504: weatherConditionImageNames.append("RainDay")
            case 511:       weatherConditionImageNames.append("Snow")
            case 520...531: weatherConditionImageNames.append("ShowerRain")
            case 600...622: weatherConditionImageNames.append("Snow")
            case 701...781: weatherConditionImageNames.append("Mist")
            case 800:       weatherConditionImageNames.append("ClearSkyDay")
            case 801:       weatherConditionImageNames.append("FewCloudsDay")
            case 802:       weatherConditionImageNames.append("Clouds")
            case 803...804: weatherConditionImageNames.append("BrokenClouds")
            default:        weatherConditionImageNames.append("questionmark.circle")
            }
        }

        return weatherConditionImageNames
    }

    var dayTemperatures: [String] {
        var dayTemperatures = [String]()

        for oneDayWeather in intermediateDailyWeather {
            let dayTemperature = String(format: "%.0f", round(oneDayWeather.temperature.day))

            switch dayTemperature {
            case "-0": dayTemperatures.append("0°")
            default:   dayTemperatures.append(dayTemperature + "°")
            }
        }

        return dayTemperatures
    }

    var nightTemperatures: [String] {
        var nightTemperatures = [String]()

        for oneDayWeather in intermediateDailyWeather {
            let nightTemperature = String(format: "%.0f", round(oneDayWeather.temperature.night))

            switch nightTemperature {
            case "-0": nightTemperatures.append("0°")
            default:   nightTemperatures.append(nightTemperature + "°")
            }
        }

        return nightTemperatures
    }

    init(intermediateDailyWeather: [DailyWeather], timeZoneOffset: Int) {
        self.intermediateDailyWeather = intermediateDailyWeather
        self.timeZoneOffset = timeZoneOffset
    }
}
