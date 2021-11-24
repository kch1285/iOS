//
//  Weather.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/24.
//

import Foundation

struct WeatherModel {
    let weatherId: Int
    let cityName: String
    let temperature: Double
    let minTemp: Double
    let maxTemp: Double
    let feelsLikeTemp: Double
    let description: String
    
    func getTemperatureString(_ temp: Double) -> String {
        return String(format: "%.1f", temp) + "°C"
    }
    
    var weatherName: String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
