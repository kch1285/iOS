//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import UIKit


enum UserNotificationType {
    case like(post: UserPost), follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController {

    private lazy var noNotificationView = NoNotificationView()
    private var models = [UserNotification]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationItem.title = "알림"
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(spinner)
     //   spinner.startAnimating()
        view.addSubview(tableView)
        
        fetchNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func layoutNoNotificationView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 4)
        noNotificationView.center = view.center
    }
    
    private func fetchNotifications() {
        let user = User(userName: "강치훈", bio: "", name: (first: "", last: ""),
                        birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1),
                        joinedDate: Date(), profilePicture: URL(string: "www.naver.com")!)
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "www.naver.com")!,
                            postUrl: URL(string: "www.naver.com")!, caption: nil, likes: [], comments: [],
                            createdDate: Date(), taggedUsers: [], owner: user)
        for x in 0...100 {
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .unfollowing), text: "Hello World",
                                         user: user)
            
            models.append(model)
        }
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
           // cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
}

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case .follow(_):
            fatalError()
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            navigationItem.largeTitleDisplayMode = .never
            navigationController?.navigationBar.topItem?.title = ""
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("didTapFollowUnfollowButton")
    }
}
