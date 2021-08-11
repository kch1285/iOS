//
//  PostViewController.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import UIKit

enum PostRenderType {
    case header(provider: User), primaryContent(provider: UserPost), actions(provider: String), comments(comments: [PostComment])
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {

    private let model: UserPost?
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.idenrifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.idenrifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.idenrifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.idenrifier)
        return tableView
    }()
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        guard let userPostModel = self.model else {
            return
        }
        var comments = [PostComment]()
        
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)", userName: "치훈강", text: "gooooood", createdDate: Date(), likes: []))
        }
        
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "String")))
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
}


extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .header(_):
            return 1
        case .primaryContent(_):
            return 1
        case .actions(_):
            return 1
        case .comments(let comments):
            return comments.count > 4 ? 4 : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.idenrifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.idenrifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.idenrifier, for: indexPath) as! IGFeedPostActionTableViewCell
            return cell
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.idenrifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .header(_):
            return 70
        case .primaryContent(_):
            return tableView.width
        case .actions(_):
            return 60
        case .comments(_):
            return 50
        }
    }
}
