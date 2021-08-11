//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/04.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollwersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollwingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("게시물", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로잉", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let follwersButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로워", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "강치훈"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "BIOBIOBIBOIBIBOIBOBIBOBIOI"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubviews()
        addButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profileImageSize = width / 4
        profileImage.layer.cornerRadius = profileImageSize / 2.0
        let buttonHeight = profileImageSize / 2
        let countsButtonWidth = (width - 10 - profileImageSize) / 3
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        
        print(buttonHeight)
        
        profileImage.frame = CGRect(x: 5, y: 5, width: profileImageSize, height: profileImageSize).integral
        postsButton.frame = CGRect(x: profileImage.right, y: profileImageSize / 2.5 + 5, width: countsButtonWidth, height: buttonHeight).integral
        follwersButton.frame = CGRect(x: postsButton.right, y: profileImageSize / 2.5 + 5, width: countsButtonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: follwersButton.right, y: profileImageSize / 2.5 + 5, width: countsButtonWidth, height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: 5, y: profileImage.bottom + buttonHeight, width: width, height: buttonHeight / 1.5).integral
        nameLabel.frame = CGRect(x: 5, y: profileImage.bottom + 5, width: width, height: 20).integral
        bioLabel.frame = CGRect(x: 5, y: nameLabel.bottom + 5, width: width, height: bioLabelSize.height).integral
    }
    
    private func addSubviews() {
        addSubview(profileImage)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(follwersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addButtonActions() {
        follwersButton.addTarget(self, action: #selector(didTapFollwersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollwingButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapFollwersButton() {
        delegate?.profileHeaderDidTapFollwersButton(self)
    }
    
    @objc private func didTapFollwingButton() {
        delegate?.profileHeaderDidTapFollwingButton(self)
    }
    
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
