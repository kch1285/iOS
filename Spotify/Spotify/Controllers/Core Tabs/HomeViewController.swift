//
//  ViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit

class HomeViewController: UIViewController {

    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        view.addSubview(settingsButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let buttonSize: CGFloat = 50
        settingsButton.frame = CGRect(x: view.width - buttonSize - 20, y: view.safeAreaInsets.top, width: buttonSize, height: buttonSize)
    }
    
    @objc private func didTapSettings() {
        print("tap")
        let vc = SettingsViewController()
        vc.title = "설정"
        vc.navigationItem.largeTitleDisplayMode = .never
    //    navigationController?.navigationBar.topItem?.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

