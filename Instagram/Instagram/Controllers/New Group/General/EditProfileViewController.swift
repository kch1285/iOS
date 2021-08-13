//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import UIKit

struct EditProfileFormMoel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController {

    private var models = [[EditProfileFormMoel]]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.idenrifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapComplete))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancel))
        
        view.addSubview(tableView)
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        let firstSectionLabel = ["이름", "사용자 이름", "웹사이트", "소개"]
        var firstSection = [EditProfileFormMoel]()
        
        for label in firstSectionLabel {
            let model = EditProfileFormMoel(label: label, placeholder: label, value: nil)
            firstSection.append(model)
        }
        models.append(firstSection)
        
        let secondSectionLabel = ["이메일 주소", "전화번호", "성별", "생일"]
        var secondSection = [EditProfileFormMoel]()
        
        for label in secondSectionLabel {
            let model = EditProfileFormMoel(label: label, placeholder: label, value: nil)
            secondSection.append(model)
        }
        models.append(secondSection)
    }
    
    // MARK: - Action
    @objc private func didTapComplete() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "프로필 사진 바꾸기", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "현재 사진 삭제", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Facebook에서 가져오기", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 찍기", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "라이브러리에서 선택", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true, completion: nil)
    }
}


extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.idenrifier, for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "개인 정보"
    }
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height / 4))
        let size = header.height / 1.5
        let profilePhoto = UIButton(frame: CGRect(x: (view.width - size) / 2, y: (header.height - size) / 2, width: size, height: size))
        
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = size / 2
        profilePhoto.addTarget(self, action: #selector(didTapProfilePhoto), for: .touchUpInside)
        profilePhoto.setImage(UIImage(systemName: "person"), for: .normal)
        profilePhoto.tintColor = .label
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        header.addSubview(profilePhoto)
        return header
    }
    
    @objc private func didTapProfilePhoto() {
        
    }
    
}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormMoel) {
        print(updatedModel.value ?? "nil")
    }
}
