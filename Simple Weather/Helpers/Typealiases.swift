//
//  Typealiases.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 05.06.2021.
//

import Foundation

typealias WeatherHandler = (Result<ResultWeather, CustomError>) -> Void
typealias NetworkHandler = (Data?, URLResponse?, Error?) -> Void
typealias LoadImageHandler = (Data?) -> Void
typealias LocationHandler = (Result<Location, CustomError>) -> Void
typealias GeocoderHandler = (String) -> Void
