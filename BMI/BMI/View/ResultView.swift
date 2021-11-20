//
//  ResultView.swift
//  BMI
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit
import SnapKit

protocol ResultViewDelegate: AnyObject {
    func recalculateButtonPressed()
}

class ResultView: UIView {
    private let backgroundImage = UIImageView(image: UIImage(named: "result_background"))
    weak var delegate: ResultViewDelegate?
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR RESULT"
        label.textColor = .white
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let bmiLabel: UILabel = {
        let label = UILabel()
        label.text = "19.5"
        label.textColor = .white
        label.font = .systemFont(ofSize: 80, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let adviceLabel: UILabel = {
        let label = UILabel()
        label.text = "EAT SOME MORE SNACKS !"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let recalculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("RECALCULATE", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 1), for: .normal)
        button.backgroundColor = .white
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
        backgroundColor = .systemBlue
        addSubview(backgroundImage)
        addSubview(resultLabel)
        addSubview(bmiLabel)
        addSubview(adviceLabel)
        addSubview(recalculateButton)
        
        recalculateButton.addTarget(self, action: #selector(didTapRecalculateButton), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        bmiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bmiLabel)
            make.bottom.equalTo(bmiLabel.snp.top).offset(10)
        }
        
        adviceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bmiLabel)
            make.top.equalTo(bmiLabel.snp.bottom).offset(10)
        }
        
        recalculateButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 15)
            make.trailing.equalToSuperview().offset(-frame.size.width / 15)
            make.bottom.equalToSuperview().offset(-frame.size.height / 20)
            make.height.equalToSuperview().dividedBy(12)
        }
    }
    
    @objc private func didTapRecalculateButton() {
        delegate?.recalculateButtonPressed()
    }
}
