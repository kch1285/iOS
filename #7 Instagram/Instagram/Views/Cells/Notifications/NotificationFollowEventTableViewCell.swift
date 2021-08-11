//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/09.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowEventTableViewCell"
    private var model: UserNotification?
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "강치훈님이 회원님을 팔로우하기 시작했습니다."
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        selectionStyle = .none
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        configureForFollow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            switch state {
            case .following:
                configureForFollow()
                break
            case .unfollowing:
                followButton.setTitle("팔로우", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
                break
            }
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    private func configureForFollow() {
        followButton.setTitle("언팔하기", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonHeight: CGFloat = 40
        let buttonWidth = contentView.width / 4
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        followButton.frame = CGRect(x: contentView.width - buttonWidth - 5, y: (contentView.height - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - buttonWidth - profileImageView.width - 16, height: contentView.height)
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
