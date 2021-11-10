//
//  LoginView.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/04.
//

import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func signUpButtonPressed()
    func loginButtonPressed()
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
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일"
        field.backgroundColor = .darkGray
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호"
        field.backgroundColor = .darkGray
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        field.keyboardType = .default
        field.isSecureTextEntry = true
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
        addSubview(emailField)
        addSubview(notiLabel)
        addSubview(signUpButton)
        addSubview(passwordField)
        
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func setUpAutoLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().dividedBy(2)
        }
        
        emailField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 9)
            make.trailing.equalToSuperview().offset(-frame.size.width / 3)
            make.top.equalTo(backgroundImage.snp.bottom).offset(10)
        }
        
        passwordField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 9)
            make.trailing.equalToSuperview().offset(-frame.size.width / 3)
            make.top.equalTo(emailField.snp.bottom).offset(10)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.leading.equalTo(emailField.snp.trailing).offset(10)
            make.top.equalTo(emailField.snp.centerY)
        }
        
        notiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-frame.size.height / 5)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(notiLabel.snp.bottom).offset(30)
        }
    }
    
    @objc private func didTapSignUpButton() {
        delegate?.signUpButtonPressed()
    }
    
    @objc private func didTapLoginButton() {
        delegate?.loginButtonPressed()
    }
}
