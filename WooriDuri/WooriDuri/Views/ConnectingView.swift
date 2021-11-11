//
//  ConnectingView.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/10.
//

import UIKit
import SnapKit

protocol ConnectingViewDelegate: AnyObject {
    func signOutButtonPressed()
    func connectButtonPressed()
}

class ConnectingView: UIView {
    
    weak var delegate: ConnectingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpAutoLayout()
        textFieldUnderline(loverNumberField)
    }
    
    private let backgroundImage = UIImageView(image: UIImage(named: "우리두리"))
    
    private let loverNumberField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.placeholder = "사랑하는 상대방의 전화번호"
        field.keyboardType = .numberPad
        return field
    }()
    
    private let connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("연결하기", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private func setUpViews() {
        backgroundColor = UIColor(red: 57/255, green: 55/255, blue: 55/255, alpha: 1) //393737
        addSubview(backgroundImage)
        addSubview(signOutButton)
        addSubview(loverNumberField)
        addSubview(connectButton)
        
        signOutButton.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
        connectButton.addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
    }
    
    private func setUpAutoLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().dividedBy(2)
        }
        
        loverNumberField.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(frame.size.width / 8)
            make.trailing.equalToSuperview().offset(-frame.size.width / 8)
        }
        
        connectButton.snp.makeConstraints { make in
            make.top.equalTo(loverNumberField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    private func textFieldUnderline(_ textField: UITextField) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.width, height: 0.4)
        border.backgroundColor = UIColor.white.cgColor
        textField.layer.addSublayer(border)
    }
    
    @objc private func didTapSignOutButton() {
        delegate?.signOutButtonPressed()
    }
    
    @objc private func didTapConnectButton() {
        delegate?.connectButtonPressed()
    }
}
