//
//  LoginViewController.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/04.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserLogin()
        setUpLoginView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    private func checkUserLogin() {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                let vc = ConnectingViewController()
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func setUpLoginView() {
        loginView.delegate = self
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func alertUserLoginError() {
        let alert = UIAlertController(title: "알림", message: "잘못된 이메일 주소 또는 비밀번호입니다. 다시 시도해 주세요.", preferredStyle: .alert)
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
    
    @objc private func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= view.frame.size.height / 4
        }
    }
    
    @objc private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginButtonPressed() {
        let emailField = loginView.emailField
        let passwordField = loginView.passwordField
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        if let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard error == nil else {
                    print("실패")
                    self?.alertUserLoginError()
                    return
                }
                print("성공")
                DispatchQueue.main.async {
                    let vc = ConnectingViewController()
                    self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    self?.navigationController?.navigationBar.isHidden = true
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func signUpButtonPressed() {
        DispatchQueue.main.async {
            let vc = SignUpViewController()
            vc.title = "회원가입"
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
