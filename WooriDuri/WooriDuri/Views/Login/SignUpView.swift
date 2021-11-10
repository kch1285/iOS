//
//  SignUpView.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/09.
//

import UIKit
import SnapKit

protocol SignUpViewDelegate: AnyObject {
    func signUpButtonPressed()
}

final class SignUpView: UIView {
    weak var delegate: SignUpViewDelegate?
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 : "
        label.textColor = .white
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호 : "
        label.textColor = .white
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 : "
        label.textColor = .white
        return label
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .darkGray
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        field.keyboardType = .emailAddress
        field.placeholder = "이메일을 입력해주세요."
        field.autocapitalizationType = .none
        return field
    }()
    
    let phoneNumberField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .darkGray
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.placeholder = "- 빼고 입력해주세요."
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .darkGray
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        field.keyboardType = .default
        field.placeholder = "비밀번호를 입력해주세요."
        field.isSecureTextEntry = true
        return field
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
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
    
    private func setUpAutoLayout() {
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 8)
            make.top.equalToSuperview().offset(safeAreaInsets.top + frame.size.width / 8)
        }
        
        emailField.snp.makeConstraints { make in
            make.leading.equalTo(emailLabel.snp.trailing).offset(10)
            make.centerY.equalTo(emailLabel)
            make.width.equalTo(frame.size.width / 2)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailLabel)
            make.top.equalTo(emailLabel.snp.bottom).offset(30)
        }
        
        phoneNumberField.snp.makeConstraints { make in
            make.leading.equalTo(phoneNumberLabel.snp.trailing).offset(10)
            make.centerY.equalTo(phoneNumberLabel)
            make.width.equalTo(frame.size.width / 2)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailLabel)
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(30)
        }

        passwordField.snp.makeConstraints { make in
            make.leading.equalTo(passwordLabel.snp.trailing).offset(10)
            make.centerY.equalTo(passwordLabel)
            make.width.equalTo(frame.size.width / 2)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
    private func setUpViews() {
        backgroundColor = UIColor(red: 57/255, green: 55/255, blue: 55/255, alpha: 1) //393737
        addSubview(emailLabel)
        addSubview(emailField)
        addSubview(phoneNumberLabel)
        addSubview(phoneNumberField)
        addSubview(passwordLabel)
        addSubview(passwordField)
        addSubview(signUpButton)
        
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapSignUpButton() {
        delegate?.signUpButtonPressed()
    }
}
