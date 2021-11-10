//
//  SignUpViewController.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/04.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignUpView()
    }

    private func setUpSignUpView() {
        view.addSubview(signUpView)
        signUpView.delegate = self
        signUpView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func alertUserSignUp() {
        let emailField = signUpView.emailField
        let passwordField = signUpView.passwordField
        
        if let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty {
            let alert = UIAlertController(title: email, message: "입력하신 이메일로 가입을 진행할까요?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] action in
                if !email.contains("@") {
                    self?.alertUserSignUpEmailError()
                }
                else if password.count < 8 {
                    self?.alertUserSignUpPasswordError()
                }
                else {
                    // 회원가입 완료!
                    print("회원가입 !!!")
                }
                
            }))
            
            alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
        
        else {
            alertUserSignUpBlankError()
        }
    }
    
    private func alertUserSignUpBlankError() {
        let alert = UIAlertController(title: "알림", message: "회원가입을 위해 모든 정보를 입력해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func alertUserSignUpEmailError() {
        let alert = UIAlertController(title: "알림", message: "올바른 이메일 형식이 아닙니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func alertUserSignUpPasswordError() {
        let alert = UIAlertController(title: "알림", message: "비밀번호는 8자리 이상이어야 합니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}


extension SignUpViewController: SignUpViewDelegate {
    func signUpButtonPressed() {
        let emailField = signUpView.emailField
        let passwordField = signUpView.passwordField
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        alertUserSignUp()
    }
}
