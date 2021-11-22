//
//  Weather.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/22.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
}
