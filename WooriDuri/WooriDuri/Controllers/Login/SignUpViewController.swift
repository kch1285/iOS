//
//  SignUpViewController.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/04.
//

import UIKit
import SnapKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignUpView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signUpView.emailField.becomeFirstResponder()
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
                    self?.alertUserSignUpError(message: "올바른 이메일 형식이 아닙니다.")
                }
                else if password.count < 8 {
                    self?.alertUserSignUpError(message: "비밀번호는 8자리 이상이어야 합니다")
                }
                else {
                    // 회원가입 완료!
                    print("회원가입 !!!")
                    FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                        guard error == nil else {
                            self?.alertUserSignUpError(message: "이미 존재하는 메일주소입니다. 다시 시도해주세요.")
                            return
                        }
                        DispatchQueue.main.async {
                            let vc = ConnectingViewController()
                            self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                            self?.navigationController?.navigationBar.isHidden = true
                            self?.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
        
        else {
            alertUserSignUpError(message: "회원가입을 위해 모든 정보를 입력해주세요.")
        }
    }
    
    private func alertUserSignUpError(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
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
