//
//  WeatherView.swift
//  WeatherApp
//
//  Created by chihoooon on 2021/11/22.
//

import UIKit
import SnapKit

class WeatherView: UIView {
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
        field.placeholder = "검색"
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
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "21°C"
        label.font = .systemFont(ofSize: 80)
        label.textColor = .label
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "London"
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
        addSubview(searchTextField)
        addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        addSubview(weatherImageView)
        addSubview(temperatureLabel)
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
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
            make.trailing.equalTo(weatherImageView)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            make.trailing.equalTo(temperatureLabel)
        }
    }
    
    @objc private func didTapSearchButton() {
        searchTextField.endEditing(true)
    }
}
