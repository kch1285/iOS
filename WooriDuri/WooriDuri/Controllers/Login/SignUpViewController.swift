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
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
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
        let phoneField = signUpView.phoneNumberField
        
        if let email = emailField.text, let password = passwordField.text, let phoneNumber = phoneField.text,
           !email.isEmpty, !password.isEmpty, !phoneNumber.isEmpty {
            let alert = UIAlertController(title: email, message: "입력하신 이메일로 가입을 진행할까요?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] action in
                if let rightEmail = self?.isEmail(email: email), rightEmail == false {
                    self?.alertUserSignUpError(message: "올바른 이메일 형식이 아닙니다.")
                }
                
                if let rightPhoneNumber = self?.isPhone(phoneNumber: phoneNumber), rightPhoneNumber == false {
                    self?.alertUserSignUpError(message: "올바른 전화번호 형식이 아닙니다.")
                }
                else if password.count < 8 {
                    self?.alertUserSignUpError(message: "비밀번호는 8자리 이상이어야 합니다")
                }
                else {
                    let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
                    FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                        guard error == nil else {
                            self?.alertUserSignUpError(message: "이미 존재하는 메일주소입니다. 다시 시도해주세요.")
                            return
                        }
                        
                        let user = UserInfo(emailAddress: safeEmail, phoneNumber: phoneNumber)
                        DatabaseManager.shared.insertUser(with: user) { [weak self] success in
                            if success {
                                print("회원가입 성공")
                                DispatchQueue.main.async {
                                    let vc = ConnectingViewController()
                                    self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                                    self?.navigationController?.navigationBar.isHidden = true
                                    self?.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                            else {
                                print("실패")
                            }
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
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func isPhone(phoneNumber: String) -> Bool {
        let regex = "^01([0-9])([0-9]{3,4})([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
    
    private func isEmail(email: String) -> Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    @objc private func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= view.frame.size.height / 5
        }
    }
    
    @objc private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
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
