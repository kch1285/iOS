//
//  SettingsViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit

class SettingsViewController: UIViewController {

    private var sections = [Section]()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "설정"
        view.backgroundColor = .systemBackground
        configure()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configure() {
        
        sections.append(Section(title: nil, options: [Option(title: "프로필 보기", handler: { [weak self] in
            self?.viewProfile()
        })]))
        
        sections.append(Section(title: nil, options: [Option(title: "계정", handler: { [weak self] in
            self?.viewProfile()
        })]))
        
        sections.append(Section(title: nil, options: [Option(title: "알림", handler: { [weak self] in
            self?.viewProfile()
        })]))
        
        sections.append(Section(title: nil, options: [Option(title: "알림", handler: { [weak self] in
            self?.viewProfile()
        })]))
        
        sections.append(Section(title: nil, options: [Option(title: "로그아웃하기", handler: { [weak self] in
            self?.didTapSignOut()
        })]))
    }
    
    private func viewProfile() {
        let vc = ProfileViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapSignOut() {
        
    }
}

//MARK: - tableView

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
}
