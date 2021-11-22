//
//  ViewController.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/22.
//

import UIKit

class WeatherViewController: UIViewController {

    private let weatherView = WeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpWeatherView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setUpWeatherView() {
        view.addSubview(weatherView)
        weatherView.searchTextField.delegate = self
        
        weatherView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = textField.text else {
            return
        }
        WeatherManager.shared.fetchWeather(city)
        textField.text = ""
    }
}
