//
//  FeaturedPlaylistsCollectionViewCell.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/25.
//

import UIKit
import SDWebImage

class FeaturedPlaylistsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistsCollectionViewCell"
    
    private let playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 70
        
        creatorNameLabel.frame = CGRect(x: 3, y: contentView.height - 30, width: contentView.width - 6, height: 30)
        playlistNameLabel.frame = CGRect(x: 3, y: contentView.height - 60, width: contentView.width - 6, height: 30)
        playlistImageView.frame = CGRect(x: (contentView.width - imageSize) / 2, y: 3, width: imageSize, height: imageSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistsCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
