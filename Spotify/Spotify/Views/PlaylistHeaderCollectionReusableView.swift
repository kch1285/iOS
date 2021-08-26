//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/26.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionReusableView"
    public weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playlistImageView)
        addSubview(playAllButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = height / 1.5
        playlistImageView.frame = CGRect(x: (width - imageSize) / 2, y: 20, width: imageSize, height: imageSize)
        nameLabel.frame = CGRect(x: 10, y: playlistImageView.bottom, width: width - 20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width - 20, height: 44)
        ownerLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width - 20, height: 44)
        playAllButton.frame = CGRect(x: width - 65, y: height - 65, width: 50, height: 50)
    }
    
    @objc private func didTapPlayAll() {
        delegate?.PlaylistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    public func configure(with viewModel: PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        playlistImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
