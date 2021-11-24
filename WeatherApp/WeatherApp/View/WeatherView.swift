//
//  WeatherView.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/22.
//

import UIKit
import SnapKit

protocol WeatherViewDelegate: AnyObject {
    func getCurrentLocation()
}

class WeatherView: UIView {
    weak var delegate: WeatherViewDelegate?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let currentLocationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    let searchTextField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.placeholder = "Search"
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 25)
        field.returnKeyType = .go
        return field
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "21°C"
        label.font = .systemFont(ofSize: 60)
        label.textColor = .label
        return label
    }()
    
    let feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like "
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        return label
    }()
    
    let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Min "
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        return label
    }()
    
    let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Max "
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Seoul"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayout()
    }
    
    private func setUpViews() {
        addSubview(backgroundImageView)
        addSubview(currentLocationButton)
        currentLocationButton.addTarget(self, action: #selector(didTapCurrentLocationButton), for: .touchUpInside)
        
        addSubview(searchTextField)
        addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        addSubview(weatherImageView)
        addSubview(descriptionLabel)
        
        addSubview(temperatureLabel)
        addSubview(feelsLikeTemperatureLabel)
        addSubview(minTemperatureLabel)
        addSubview(maxTemperatureLabel)
        
        addSubview(cityLabel)
    }
    
    private func setUpLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(frame.size.height / 15)
            make.leading.equalToSuperview().offset(frame.size.width / 8)
            make.width.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(currentLocationButton)
            make.leading.equalTo(currentLocationButton.snp.trailing).offset(10)
            make.width.equalToSuperview().dividedBy(2)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(currentLocationButton)
            make.trailing.equalToSuperview().offset(-frame.size.width / 8)
            make.width.height.equalTo(40)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.width.height.equalTo(frame.size.width / 3)
            make.top.equalTo(searchButton.snp.bottom).offset(10)
            make.trailing.equalTo(searchButton)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(weatherImageView)
            make.top.equalTo(weatherImageView.snp.bottom).offset(5)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.trailing.equalTo(weatherImageView)
        }
        
        feelsLikeTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            make.trailing.equalTo(temperatureLabel)
        }
        
        minTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeTemperatureLabel.snp.bottom).offset(5)
            make.trailing.equalTo(temperatureLabel)
        }
        
        maxTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(minTemperatureLabel.snp.bottom).offset(5)
            make.trailing.equalTo(temperatureLabel)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(maxTemperatureLabel.snp.bottom).offset(10)
            make.trailing.equalTo(temperatureLabel)
        }
    }
    
    @objc private func didTapSearchButton() {
        searchTextField.endEditing(true)
    }
    
    @objc private func didTapCurrentLocationButton() {
        delegate?.getCurrentLocation()
    }
}
