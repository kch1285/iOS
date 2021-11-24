//
//  ViewController.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    private let weatherView = WeatherView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WeatherManager.shared.delegate = self
        setUpLocationManager()
        setUpWeatherView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setUpWeatherView() {
        view.addSubview(weatherView)
        weatherView.searchTextField.delegate = self
        weatherView.delegate = self
        
        weatherView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = textField.text, city != "" else {
            return
        }
        print(city)
        WeatherManager.shared.fetchWeather(city)
        textField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherView.weatherImageView.image = UIImage(systemName: weather.weatherName)
            self.weatherView.descriptionLabel.text = weather.description
            self.weatherView.temperatureLabel.text = weather.getTemperatureString(weather.temperature)
            self.weatherView.feelsLikeTemperatureLabel.text = "Feels like " + weather.getTemperatureString(weather.feelsLikeTemp)
            self.weatherView.minTemperatureLabel.text = "Min " + weather.getTemperatureString(weather.minTemp)
            self.weatherView.maxTemperatureLabel.text = "Max " + weather.getTemperatureString(weather.maxTemp)
            self.weatherView.cityLabel.text = weather.cityName
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        locationManager.stopUpdatingLocation()
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        WeatherManager.shared.fetchWeather(latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - WeatherViewDelegate
extension WeatherViewController: WeatherViewDelegate {
    func getCurrentLocation() {
        locationManager.requestLocation()
    }
}
