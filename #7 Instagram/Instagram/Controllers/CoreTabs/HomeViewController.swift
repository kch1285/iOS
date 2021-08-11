//
//  ViewController.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {

    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.idenrifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.idenrifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.idenrifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.idenrifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        createMockModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuthStatus()
    }

    private func createMockModel() {
        let user = User(userName: "강치훈", bio: "", name: (first: "", last: ""),
                        birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1),
                        joinedDate: Date(), profilePicture: URL(string: "www.naver.com")!)
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "www.naver.com")!,
                            postUrl: URL(string: "www.naver.com")!, caption: nil, likes: [], comments: [],
                            createdDate: Date(), taggedUsers: [], owner: user)
        var comments = [PostComment]()
        
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)", userName: "갱치훈", text: "하이하이", createdDate: Date(), likes: []))
        }
        
        let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                comments: PostRenderViewModel(renderType: .comments(comments: comments)))
        for x in 0..<5 {
            feedRenderModels.append(viewModel)
        }
    }
    
    private func checkAuthStatus() {
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        let subSection = x % 4
        let position = x % 4 == 0 ? x / 4 : (x - (x % 4)) / 4
        model = feedRenderModels[position]
        
        if subSection == 0 {
            // header
            return 1
        }
        else if subSection == 1 {
            // post
            return 1
        }
        else if subSection == 2 {
            // actions
            return 1
        }
        else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            
            switch commentsModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            case .actions, .header, .primaryContent:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        let subSection = x % 4
        let position = x % 4 == 0 ? x / 4 : (x - (x % 4)) / 4
        model = feedRenderModels[position]
        
        if subSection == 0 {
            // header
            let headerModel = model.header
            
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.idenrifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .actions, .comments, .primaryContent:
                return UITableViewCell()
            }
        }
        else if subSection == 1 {
            // post
            let postModel = model.post
            
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.idenrifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .actions, .comments, .header:
                return UITableViewCell()
            }
        }
        else if subSection == 2 {
            // actions
            let actionModel = model.actions
            
            switch actionModel.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.idenrifier, for: indexPath) as! IGFeedPostActionTableViewCell
                cell.delegate = self
                return cell
            case .header, .comments, .primaryContent:
                return UITableViewCell()
            }
        }
        else if subSection == 3 {
            // comments
            let commentModel = model.comments
            
            switch commentModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.idenrifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .actions, .header, .primaryContent:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            return 60
        }
        else if subSection == 1 {
            return tableView.width
        }
        else if subSection == 2 {
            return 60
        }
        else if subSection == 3 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapDotButton() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "신고", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        actionSheet.addAction(UIAlertAction(title: "링크 복사", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "공유 대상...", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "게시물 알림 설정", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "숨기기", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "팔로우 취소", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    func reportPost() {
        
    }
}

extension HomeViewController: IGFeedPostActionTableViewCellDelegate {
    func didTapLikeButton() {
        
    }
    
    func didTapCommentButton() {
        
    }
    
    func didTapSendButton() {
        
    }
}
