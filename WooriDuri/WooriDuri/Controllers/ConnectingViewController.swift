//
//  ViewController.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/04.
//

import UIKit
import SnapKit
import FirebaseAuth

class ConnectingViewController: UIViewController {

    private let connectingView = ConnectingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(connectingView)
        connectingView.delegate = self
        connectingView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

extension ConnectingViewController: ConnectingViewDelegate {
    func signOutButtonPressed() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        catch {
            print("로그아웃 실패")
        }
    }
}
