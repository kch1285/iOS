//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/05.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}

enum FollowState {
    case follow, unfollow
}

struct UserRelationship {
    let id: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowTableViewCell"
    private var model: UserRelationship?
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.tintColor = .label
        label.text = "아이디"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.tintColor = .lightGray
        label.text = "이름"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .systemBackground
        button.setTitle("팔로잉", for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let dotButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .systemBackground
        button.setTitle("•••", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        selectionStyle = .none
        addSubviews()
    }
    
    private func addSubviews() {
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(followButton)
        contentView.addSubview(dotButton)
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        idLabel.text = nil
        nameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        dotButton.setTitle(nil, for: .normal)
        dotButton.backgroundColor = nil
        dotButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let labelHeight = contentView.height / 2
        let buttonWidth = contentView.width / 4
        print(buttonWidth)
        dotButton.frame = CGRect(x: contentView.width - 5 - (buttonWidth / 2), y: 30, width: buttonWidth / 2, height: 15)
        followButton.frame = CGRect(x: contentView.width - 5 - (buttonWidth * 1.5), y: 22.5, width: buttonWidth, height: 30)
        idLabel.frame = CGRect(x: profileImageView.right, y: 0, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
        nameLabel.frame = CGRect(x: profileImageView.right, y: idLabel.bottom, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserRelationship) {
        self.model = model
        idLabel.text = model.id
        nameLabel.text = model.name
        switch model.type {
        case .follow:
            followButton.setTitle("팔로잉", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.darkGray.cgColor
        case .unfollow:
            followButton.setTitle("팔로우", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
            followButton.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
