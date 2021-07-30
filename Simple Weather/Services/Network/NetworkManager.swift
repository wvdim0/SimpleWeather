//
//  NetworkManager.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 03.06.2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func performRequest(for requestType: NetworkRequestType, completion: @escaping WeatherHandler)
    func loadImage(_ handler: @escaping LoadImageHandler)
}

final class NetworkManager: NetworkManagerProtocol {
    // MARK: - Properties

    private var completion: WeatherHandler?

    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    // MARK: - NetworkManagerProtocol conforming methods

    func performRequest(for requestType: NetworkRequestType, completion: @escaping WeatherHandler) {
        self.completion = completion

        switch requestType {
        case .city(cityName: let city):
            let queryItems = [URLQueryItem(name: "q", value: city)]

            getWeatherLocationJSON(for: Constants.URL.owmWeatherURL, queryItems: queryItems)
        case .coordinates(let (latitude, longitude)):
            let queryItems = [
                URLQueryItem(name: "lat", value: "\(latitude)"),
                URLQueryItem(name: "lon", value: "\(longitude)")
            ]

            getWeatherLocationJSON(for: Constants.URL.owmWeatherURL, queryItems: queryItems)
        }
    }

    func loadImage(_ handler: @escaping LoadImageHandler) {
        let imageURL = URL(string: Constants.URL.imageURL)

        guard let url = imageURL else { handler(nil); return }

        let networkHandler: NetworkHandler = { data, response, error in
            if let data = data,
               (response as? HTTPURLResponse)?.statusCode == 200,
               error == nil {
                handler(data)
            } else {
                handler(nil)
            }
        }

        session.dataTask(with: url, completionHandler: networkHandler).resume()
    }

    // MARK: - Private methods

    private func getWeatherLocationJSON(for urlString: String, queryItems: [URLQueryItem]) {
        var components = URLComponents(string: urlString)

        let defaultQueryItems = [
            URLQueryItem(name: "appId", value: Constants.APIKeys.owmAPIKey),
            URLQueryItem(name: "lang", value: "ru"),
            URLQueryItem(name: "units", value: "metric")
        ]

        components?.queryItems = queryItems + defaultQueryItems

        guard let url = components?.url else {
            completion?(.failure(CustomError(description: Constants.ErrorMesages.weatherError)))

            return
        }

        let networkHandler: NetworkHandler = { [weak self] data, response, error in
            guard let self = self else { return }

            if let data = data,
               (response as? HTTPURLResponse)?.statusCode == 200,
               error == nil {
                if let weatherLocation = self.parseWeatherLocationJSON(with: data) {
                    self.getWeatherJSON(for: weatherLocation)
                } else {
                    self.completion?(.failure(CustomError(description: Constants.ErrorMesages.weatherError)))
                }
            } else if error?._code == -1009 {
                self.completion?(.failure(CustomError(description: Constants.ErrorMesages.noInternetConnection)))
            } else if (response as? HTTPURLResponse)?.statusCode == 404 {
                self.completion?(.failure(CustomError(description: Constants.ErrorMesages.placeNotFound)))
            } else {
                self.completion?(.failure(CustomError(description: Constants.ErrorMesages.weatherError)))
            }
        }

        session.dataTask(with: url, completionHandler: networkHandler).resume()
    }

    private func parseWeatherLocationJSON(with data: Data) -> WeatherLocation? {
        do {
            let weatherLocation = try decoder.decode(WeatherLocation.self, from: data)

            return weatherLocation
        } catch {
            return nil
        }
    }

    private func getWeatherJSON(for weatherLocation: WeatherLocation) {
        var components = URLComponents(string: Constants.URL.owmOneCallURL)

        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(weatherLocation.coordinates.latitude)"),
            URLQueryItem(name: "lon", value: "\(weatherLocation.coordinates.longitude)"),
            URLQueryItem(name: "exclude", value: "minutely,hourly,alerts"),
            URLQueryItem(name: "appId", value: Constants.APIKeys.owmAPIKey),
            URLQueryItem(name: "lang", value: "ru"),
            URLQueryItem(name: "units", value: "metric")
        ]

        guard let url = components?.url else {
            completion?(.failure(CustomError(description: Constants.ErrorMesages.weatherError)))

            return
        }

        let networkHandler: NetworkHandler = { [weak self] data, response, error in
            guard let self = self else { return }

            if let data = data,
               (response as? HTTPURLResponse)?.statusCode == 200,
               error == nil {
                if let weather = self.parseWeatherJSON(with: data) {
                    let resultWeather = ResultWeather(weatherLocation: weatherLocation, weather: weather)
                    self.completion?(.success(resultWeather))
                } else {
                    self.completion?(.failure(CustomError(description: Constants.ErrorMesages.weatherError)))
                }
            } else if error?._code == -1009 {
                self.completion?(.failure(CustomError(description: Constants.ErrorMesages.noInternetConnection)))
            } else if (response as? HTTPURLResponse)?.statusCode == 404 {
                self.completion?(.failure(CustomError(description: Constants.ErrorMesages.placeNotFound)))
            } else {
                self.completion?(.failure(CustomError(description: Constants.ErrorMesages.weatherError)))
            }
        }

        session.dataTask(with: url, completionHandler: networkHandler).resume()
    }

    private func parseWeatherJSON(with data: Data) -> Weather? {
        do {
            let weather = try decoder.decode(Weather.self, from: data)

            return weather
        } catch {
            return nil
        }
    }
}
