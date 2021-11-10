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
        setUpLoginView()
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
}

extension LoginViewController: LoginViewDelegate {
    func loginButtonPressed() {
        
    }
    
    func signUpButtonPressed() {
        DispatchQueue.main.async {
            let vc = SignUpViewController()
            vc.title = "회원가입"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
