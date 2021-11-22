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

    private func setUpWeatherView() {
        view.addSubview(weatherView)
        weatherView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }

}

