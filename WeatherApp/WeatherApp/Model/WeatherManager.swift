//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/22.
//

import Foundation

struct WeatherManager {
    static let shared = WeatherManager()
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a37f0e771baaeb266c238c4285014c27&units=metric"
    private init() {}
    
    func fetchWeather(_ cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        //  Create URL
        guard let url = URL(string: urlString) else {
            return
        }
        
        //  Create URLSession
        let session = URLSession(configuration: .default)
        
        //  Give Session task
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error!.localizedDescription)
                return
            }
            parseJSON(data)
        }
        
        //  Start task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(WeatherResponse.self, from: weatherData)
            print(data)
        }
        catch {
            print(error.localizedDescription)
            
        }
    }
}
