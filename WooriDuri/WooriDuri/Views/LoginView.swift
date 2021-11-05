//
//  LoginView.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/04.
//

import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func SignUpButtonPressed()
    func LoginButtonPressed()
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let phoneNumberField: UITextField = {
        let field = UITextField()
        field.placeholder = "휴대폰 번호를 입력하세요."
        field.backgroundColor = .darkGray
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        field.keyboardType = .numberPad
        return field
    }()
    
    private let backgroundImage = UIImageView(image: UIImage(named: "우리두리"))
    
    private let notiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "회원이 아니신가요?"
        label.textColor = .white
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입하기", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.setTitleColor(.white, for: .normal)
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
        setUpAutoLayout()
    }
    
    private func setUpViews() {
        backgroundColor = UIColor(red: 57/255, green: 55/255, blue: 55/255, alpha: 1) //393737
        addSubview(backgroundImage)
        addSubview(loginButton)
        addSubview(phoneNumberField)
        addSubview(notiLabel)
        addSubview(signUpButton)
        
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func setUpAutoLayout() {
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-frame.size.width / 8)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
        }
        
        phoneNumberField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 8)
            make.centerY.equalToSuperview()
        }
        
        notiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-frame.size.height / 4)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(notiLabel.snp.bottom).offset(50)
        }
    }
    
    @objc private func didTapSignUpButton() {
        delegate?.SignUpButtonPressed()
    }
    
    @objc private func didTapLoginButton() {
        delegate?.LoginButtonPressed()
    }
}
