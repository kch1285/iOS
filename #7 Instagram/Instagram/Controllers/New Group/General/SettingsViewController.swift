//
//  SettingsViewController.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

enum SettingURLType {
    case terms, privacy, help
}

final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.title = ""
        configureModels()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        data.append([
            SettingCellModel(title: "프로필 편집", handler: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "친구 팔로우 및 초대", handler: { [weak self] in
                self?.didTapFollowOrInviteFriends()
            }),
            SettingCellModel(title: "보관", handler: { [weak self] in
                self?.didTapKeepPost()
            })
        ])
        
        data.append([
            SettingCellModel(title: "이용 약관", handler: { [weak self] in
                self?.openUrl(type: .terms)
            }),
            SettingCellModel(title: "개인정보 정책", handler: { [weak self] in
                self?.openUrl(type: .privacy)
            }),
            SettingCellModel(title: "도움말", handler: { [weak self] in
                self?.openUrl(type: .help)
            })
        ])
        
        data.append([
            SettingCellModel(title: "로그아웃", handler: { [weak self] in
                self?.didTapLogOut()
            })
        ])
    }

    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "프로필 편집"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen

        present(navVC, animated: true, completion: nil)
    }
    
    private func didTapFollowOrInviteFriends() {
        
    }
    
    private func didTapKeepPost() {
        
    }
    
    private func openUrl(type: SettingURLType) {
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    private func didTapLogOut() {
        let alert = UIAlertController(title: nil, message: "로그아웃 하시겠어요?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        })
                    }
                    else {
                        fatalError()
                    }
                }
            })
        }))
        
        alert.popoverPresentationController?.sourceView = tableView
        alert.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(alert, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
