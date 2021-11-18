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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ConnectingViewController: ConnectingViewDelegate {
    func connectButtonPressed() {
        //번호 확인해서 그 번호 사람한테 푸시 알림 및 alert action..
        NotificationManager.sendNotification("우리두리", subtitle: "**님이 연결을 요청하셨어요!!", body: "받아라", seconds: 1)
    }
    
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