//
//  CreatePlaylistViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/09/02.
//

import UIKit
import Foundation

class CreatePlaylistViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "플레이리스트에 이름을 지정하세요."
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    
    private let playlistNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "내 플레이리스트"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 40, weight: .bold)
        textField.textColor = .label
        textField.borderStyle = .bezel
        return textField
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondaryLabel
        button.setTitle("만들기", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .secondarySystemBackground
        configureBarButton()
        createButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        playlistNameTextField.becomeFirstResponder()
        
        view.addSubview(label)
        view.addSubview(playlistNameTextField)
        view.addSubview(createButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonWidth: CGFloat = 100
        label.frame = CGRect(x: 0, y: 100, width: view.width, height: 100)
        playlistNameTextField.frame = CGRect(x: 10, y: label.bottom + 50, width: view.width - 20, height: 100)
        createButton.frame = CGRect(x: (view.width - buttonWidth) / 2, y: playlistNameTextField.bottom + 50, width: buttonWidth, height: 50)
    }
    
    private func configureBarButton() {
        navigationController?.navigationBar.tintColor = .label
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }

    @objc private func didTapCreate() {
        guard let text = playlistNameTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        APICaller.shared.createPlaylist(with: text) { [weak self] success in
            if success {
                NotificationCenter.default.post(name: .playlistCreatedNotification, object: nil)
                DispatchQueue.main.async {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
            else {
                print("Failed to create playlist !!!")
            }
        }
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
