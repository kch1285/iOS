//
//  ResultView.swift
//  Tipsy
//
//  Created by chihoooon on 2021/11/21.
//

import UIKit
import SnapKit

protocol ResultViewDelegate: AnyObject {
    func recalculate()
}

class ResultView: UIView {
    weak var delegate: ResultViewDelegate?
    
    private let resultInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Total per person"
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = UIColor(red: 149/255, green: 154/255, blue: 153/255, alpha: 1)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "56.32"
        label.font = .systemFont(ofSize: 45, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0, green: 176/255, blue: 107/255, alpha: 1)
        return label
    }()
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Split between 2 people, with 10% tip."
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = UIColor(red: 149/255, green: 154/255, blue: 153/255, alpha: 1)
        return label
    }()
    
    private let recalculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recalculate", for: .normal)
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
        addSubview(resultInfoLabel)
        addSubview(resultLabel)
        addSubview(settingsLabel)
        addSubview(recalculateButton)
        recalculateButton.addTarget(self, action: #selector(didTapRecalculateButton), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        resultInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(frame.size.height / 8)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(resultInfoLabel.snp.bottom).offset(10)
        }
        
        settingsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultLabel.snp.bottom).offset(30)
        }
        
        recalculateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(200)
            make.bottom.equalToSuperview().offset(-frame.size.height / 20)
        }
    }
    
    @objc private func didTapRecalculateButton() {
        delegate?.recalculate()
    }
}
