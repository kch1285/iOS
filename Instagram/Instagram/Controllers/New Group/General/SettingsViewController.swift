//
//  SettingsViewController.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
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
        
        configureModels()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        let section = [SettingCellModel(title: "로그아웃", handler: { [weak self] in
            self?.didTapLogOut()
        })]
        data.append(section)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
