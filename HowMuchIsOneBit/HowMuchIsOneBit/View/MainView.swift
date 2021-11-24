//
//  MainView.swift
//  HowMuchIsOneBit
//
//  Created by chihoooon on 2021/11/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private let safeArea: UIView = {
        let view = UIView()
        return view
    }()
    
    private let bitCoinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bitcoinsign.circle")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let bitCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "BitCoin"
        label.textColor = UIColor(named: "Title Color")
        label.font = .systemFont(ofSize: 50, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let bitCoinValueLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let pickerView: UIPickerView = {
        let view = UIPickerView()
        view.alpha = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSafeArea()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayout()
    }
    
    private func setUpSafeArea() {
        safeArea.translatesAutoresizingMaskIntoConstraints = false
        addSubview(safeArea)
        if #available(iOS 11, *) {
            let guide = safeAreaLayoutGuide
            safeArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            safeArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            safeArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            safeArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        }
    }
    
    private func setUpViews() {
        backgroundColor = UIColor(named: "Background Color")
        safeArea.addSubview(bitCoinLabel)
        safeArea.addSubview(bitCoinImageView)
        safeArea.addSubview(bitCoinValueLabel)
        safeArea.addSubview(unitLabel)
        safeArea.addSubview(pickerView)
    }
    
    private func setUpLayout() {
        bitCoinLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        bitCoinImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.equalTo(bitCoinLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(frame.size.width / 50)
        }
        
        bitCoinValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bitCoinImageView)
            make.leading.equalTo(bitCoinImageView.snp.trailing).offset(5)
            make.trailing.equalTo(unitLabel.snp.leading).offset(5)
        }
        
        unitLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.centerY.equalTo(bitCoinImageView)
            make.trailing.equalTo(-frame.size.width / 50)
        }
        
        pickerView.snp.makeConstraints { make in
            make.width.bottom.equalToSuperview()
        }
    }
}
