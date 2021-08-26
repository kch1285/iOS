//
//  CategoryCollectionViewCell.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/26.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let colors: [UIColor] = [
        .systemPink, .systemRed, .systemBlue, .systemTeal,
        .systemGray, .systemFill, .systemGreen, .systemOrange,
        .systemYellow, .systemPurple, .systemIndigo
    ]
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.image = UIImage(systemName: "music.note.list", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: contentView.height / 2, width: contentView.width - 20, height: contentView.height / 2)
        imageView.frame = CGRect(x: contentView.width / 2, y: 10, width: contentView.width / 2, height: contentView.height / 2)
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
}
