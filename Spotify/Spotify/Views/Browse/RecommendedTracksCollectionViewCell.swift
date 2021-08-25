//
//  RecommendedTracksCollectionViewCell.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/25.
//

import UIKit
import SDWebImage

class RecommendedTracksCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTracksCollectionViewCell"
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 4
        
        albumImageView.frame = CGRect(x: 5, y: 2, width: imageSize, height: imageSize)
        trackNameLabel.frame = CGRect(x: albumImageView.right + 10, y: 0, width: contentView.width - albumImageView.right - 15, height: contentView.height / 2)
        artistNameLabel.frame = CGRect(x: albumImageView.right + 10, y: contentView.height / 2, width: contentView.width - albumImageView.right - 15, height: contentView.height / 2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTracksCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
