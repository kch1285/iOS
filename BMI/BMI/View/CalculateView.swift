//
//  CalculateView.swift
//  BMI
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit
import SnapKit

protocol CalculateViewDelegate: AnyObject {
    func calculate()
    func heightUpdate(_ slider: UISlider)
    func weightUpdate(_ slider: UISlider)
}

class CalculateView: UIView {
    weak var delegate: CalculateViewDelegate?
    
    private let backgroundView = UIImageView(image: UIImage(named: "calculate_background"))
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    let heightValueLabel: UILabel = {
        let label = UILabel()
        label.text = "1.5m"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    private let heightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 3
        slider.setValue(1.5, animated: true)
        slider.minimumTrackTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.52)
        slider.thumbTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.5)
        return slider
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    let weightValueLabel: UILabel = {
        let label = UILabel()
        label.text = "100Kg"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    private let weightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 200
        slider.setValue(100, animated: true)
        slider.minimumTrackTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.52)
        slider.thumbTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.5)
        return slider
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "CALCULATE YOUR BMI"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("CALCULATE", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = UIColor(red: 98/255, green: 96/255, blue: 157/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
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
    
    @objc private func didTapCalculateButton() {
        delegate?.calculate()
    }
    
    @objc private func heightSliderChanged(_ slider: UISlider) {
        delegate?.heightUpdate(slider)
    }
    
    @objc private func weightSliderChanged(_ slider: UISlider) {
        delegate?.weightUpdate(slider)
    }
}

//MARK: - View Settings
extension CalculateView {
    private func setUpViews() {
        addSubview(backgroundView)
        addSubview(descriptionLabel)
        
        addSubview(heightLabel)
        addSubview(heightValueLabel)
        addSubview(heightSlider)
        heightSlider.addTarget(self, action: #selector(heightSliderChanged(_:)), for: .valueChanged)
        
        addSubview(weightLabel)
        addSubview(weightValueLabel)
        addSubview(weightSlider)
        weightSlider.addTarget(self, action: #selector(weightSliderChanged(_:)), for: .valueChanged)
        
        addSubview(calculateButton)
        calculateButton.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        backgroundView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 15)
            make.trailing.equalToSuperview().offset(-frame.size.width / 15)
            make.height.equalTo(frame.size.height * 0.6)
            make.top.equalToSuperview()
        }
        
        heightLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        heightValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(descriptionLabel)
            make.top.equalTo(heightLabel)
        }
        
        heightSlider.snp.makeConstraints { make in
            make.trailing.leading.equalTo(descriptionLabel)
            make.top.equalTo(heightLabel.snp.bottom).offset(10)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel)
            make.top.equalTo(heightSlider.snp.bottom).offset(10)
        }
        
        weightValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(descriptionLabel)
            make.top.equalTo(weightLabel)
        }
        
        weightSlider.snp.makeConstraints { make in
            make.trailing.leading.equalTo(descriptionLabel)
            make.top.equalTo(weightLabel.snp.bottom).offset(10)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.trailing.leading.equalTo(descriptionLabel)
            make.bottom.equalToSuperview().offset(-frame.size.height / 20)
            make.height.equalToSuperview().dividedBy(12)
        }
    }
}
