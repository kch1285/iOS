//
//  CalculateView.swift
//  Tipsy
//
//  Created by chihoooon on 2021/11/21.
//

import UIKit
import SnapKit

protocol CalculateViewDelegate: AnyObject {
    func tipChanged(_ tip: UIButton)
    func calculate(splitNumber: String)
    func stepperChanged(_ stepper: UIStepper)
}

class CalculateView: UIView {
    weak var delegate: CalculateViewDelegate?
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Enter bill total"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let tipLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Select Tip"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let splitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Choose Split"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    let splitNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "2"
        label.textColor = UIColor(red: 0, green: 176/255, blue: 107/255, alpha: 1)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35)
        return label
    }()
    
    let billtextField: UITextField = {
        let field = UITextField()
        field.textColor = UIColor(red: 0, green: 176/255, blue: 107/255, alpha: 1)
        field.font = .systemFont(ofSize: 40)
        field.placeholder = "e.g. 123.45"
        field.textAlignment = .center
        return field
    }()
    
    private let zeroPctButton: UIButton = {
        let button = UIButton()
        button.setTitle("0%", for: .normal)
        button.setTitleColor(.systemPink, for: .selected)
        button.setTitleColor(UIColor(red: 0, green: 176/255, blue: 107/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        return button
    }()
    
    private let tenPctButton: UIButton = {
        let button = UIButton()
        button.setTitle("10%", for: .normal)
        button.setTitleColor(.systemPink, for: .selected)
        button.setTitleColor(UIColor(red: 0, green: 176/255, blue: 107/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        button.isSelected = true
        return button
    }()
    
    private let twentyPctButton: UIButton = {
        let button = UIButton()
        button.setTitle("20%", for: .normal)
        button.setTitleColor(.systemPink, for: .selected)
        button.setTitleColor(UIColor(red: 0, green: 176/255, blue: 107/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        return button
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2
        stepper.minimumValue = 2
        stepper.maximumValue = 25
        stepper.stepValue = 1
        return stepper
    }()
    
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        button.backgroundColor = UIColor(red: 0, green: 176/255, blue: 107/255, alpha: 1)
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
    
    private func setUpViews() {
        backgroundColor = UIColor(red: 215/255, green: 249/255, blue: 235/255, alpha: 1)
        addSubview(infoLabel)
        addSubview(billtextField)
        
        addSubview(tipLabel)
        addSubview(zeroPctButton)
        addSubview(tenPctButton)
        addSubview(twentyPctButton)
        zeroPctButton.addTarget(self, action: #selector(didTipChanged(_:)), for: .touchUpInside)
        tenPctButton.addTarget(self, action: #selector(didTipChanged(_:)), for: .touchUpInside)
        twentyPctButton.addTarget(self, action: #selector(didTipChanged(_:)), for: .touchUpInside)
        
        addSubview(splitLabel)
        addSubview(splitNumberLabel)
        addSubview(stepper)
        stepper.addTarget(self, action: #selector(didStepperChanged(_:)), for: .valueChanged)
        
        addSubview(calculateButton)
        calculateButton.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(frame.size.height / 15)
        }
        
        billtextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
        }
        
        tipLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(billtextField.snp.bottom).offset(30)
        }
        
        zeroPctButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 8)
            make.top.equalTo(tipLabel.snp.bottom).offset(10)
        }
        
        tenPctButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zeroPctButton)
        }
        
        twentyPctButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-frame.size.width / 8)
            make.top.equalTo(zeroPctButton)
        }
        
        splitLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tenPctButton.snp.bottom).offset(30)
        }
        
        splitNumberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 4)
            make.top.equalTo(splitLabel.snp.bottom).offset(10)
        }
        
        stepper.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-frame.size.width / 4)
            make.top.equalTo(splitNumberLabel)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(200)
            make.bottom.equalToSuperview().offset(-frame.size.height / 20)
        }
    }
    
    @objc private func didTipChanged(_ tip: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        tip.isSelected = true
        
        delegate?.tipChanged(tip)
    }
    
    @objc private func didStepperChanged(_ stepper: UIStepper) {
        delegate?.stepperChanged(stepper)
    }
    
    @objc private func didTapCalculateButton() {
        guard let splitNumber = splitNumberLabel.text else {
            return
        }
        delegate?.calculate(splitNumber: splitNumber)
    }
}
