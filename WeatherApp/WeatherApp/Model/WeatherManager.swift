//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate: AnyObject {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    static var shared = WeatherManager()
    var delegate: WeatherManagerDelegate?
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a37f0e771baaeb266c238c4285014c27&units=metric"
    private init() {}
    
    func fetchWeather(_ cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)".replacingOccurrences(of: " ", with: "%20")
        performRequest(with: urlString)
    }
    
    func fetchWeather(_ latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        //  Create URL
        guard let url = URL(string: urlString) else {
            return
        }
        
        //  Create URLSession
        let session = URLSession(configuration: .default)
        
        //  Give Session task
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                delegate?.didFailWithError(error!)
                return
            }
            guard let weather = parseJSON(data) else {
                return
            }
            
            delegate?.didUpdateWeather(weather)
        }
        
        //  Start task
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(WeatherResponse.self, from: weatherData)
            guard let id = data.weather.first?.id else {
                return nil
            }
            let cityName = data.name
            let temperature = data.main.temp
            let minTemp = data.main.temp_min
            let maxTemp = data.main.temp_max
            let feelsLikeTemp = data.main.feels_like
            guard let desc = data.weather.first?.description else {
                return nil
            }
            
            let weather = WeatherModel(weatherId: id, cityName: cityName, temperature: temperature, minTemp: minTemp, maxTemp: maxTemp, feelsLikeTemp: feelsLikeTemp, description: desc)
            return weather
        }
        catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
