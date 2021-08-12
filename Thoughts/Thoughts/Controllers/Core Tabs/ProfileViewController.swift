//
//  ProfileViewController.swift
//  Thoughts
//
//  Created by chihoooon on 2021/08/11.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "로그아웃", style: .done, target: self, action: #selector((didTapSignOut)))
    }

    @objc private func didTapSignOut() {
        
    }
}
