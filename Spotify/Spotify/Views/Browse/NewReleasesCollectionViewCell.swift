//
//  NewReleasesCollectionViewCell.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/25.
//

import UIKit
import SDWebImage

class NewReleasesCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 1
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
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        let imageSize: CGFloat = contentView.height - 10
        let albumNameLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10, height: contentView.height - 10))
        let albumNameLabelHeight = min(60, albumNameLabelSize.height)
        
        albumImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        albumNameLabel.frame = CGRect(x: albumImageView.right + 10, y: 5, width: albumNameLabelSize.width, height: albumNameLabelHeight)
        artistNameLabel.frame = CGRect(x: albumImageView.right + 10, y: albumNameLabel.bottom, width: contentView.width - albumImageView.right - 10, height: 30)
        numberOfTracksLabel.frame = CGRect(x: albumImageView.right + 10, y: contentView.bottom - 44, width: numberOfTracksLabel.width, height: 44)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
