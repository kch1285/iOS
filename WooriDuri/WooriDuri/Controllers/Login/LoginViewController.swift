//
//  LoginViewController.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/04.
//

import UIKit
import SnapKit

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
    
}

extension LoginViewController: LoginViewDelegate {
    func LoginButtonPressed() {
        DispatchQueue.main.async {
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func SignUpButtonPressed() {
        DispatchQueue.main.async {
            let vc = SignUpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
