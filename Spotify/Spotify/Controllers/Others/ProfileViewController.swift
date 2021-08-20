//
//  ProfileViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        fetchProfile()
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchProfile() {
        DispatchQueue.main.async {
            APICaller.shared.getCurrentUserProfile { [weak self] result in
                print("ProfileViewController")
                switch result {
                case .failure(let error):
                    self?.failedToGetProfile()
                    print(error.localizedDescription)
                case .success(let model):
                    self?.updateUI(with: model)
                    break
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        models.append("이름 : \(model.display_name)")
        models.append("국적 : \(model.country)")
        models.append("이메일 : \(model.email)")
        models.append("사용자 이름 : \(model.id)")
        models.append("이름 : \(model.display_name)")
        models.append("이름 : \(model.display_name)")
        models.append("이름 : \(model.display_name)")
        createTableHeader(with: model.images.first?.url)
        
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    private func createTableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        
        print(url)
        
        DispatchQueue.main.async {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height / 2))
            
            let imageSize: CGFloat = headerView.height / 2
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
            imageView.center = headerView.center
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageSize / 2
            imageView.sd_setImage(with: url, completed: nil)
            
            headerView.addSubview(imageView)
            self.tableView.tableHeaderView = headerView
        }
    }
    
    private func failedToGetProfile() {
        DispatchQueue.main.async {
            let label = UILabel(frame: .zero)
            label.text = "프로필을 가져오지 못했습니다."
            label.sizeToFit()
            label.textColor = .secondaryLabel
            label.center = self.view.center
            self.view.addSubview(label)
        }
    }
}

//MARK: - tableView

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
    
    
}
