//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/04.
//

import UIKit
import SDWebImage

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapDotButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let idenrifier = "IGFeedPostHeaderTableViewCell"
    public weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let dotButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dotButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        contentView.addSubview(userLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(dotButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height - 4
        
        profileImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profileImageView.layer.cornerRadius = size / 2
        dotButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        userLabel.frame = CGRect(x: profileImageView.right + 10, y: 2, width: contentView.width - (size * 2) - 15, height: contentView.height - 4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userLabel.text = nil
        profileImageView.image = nil
    }
    
    public func configure(with model: User) {
        userLabel.text = model.userName
        profileImageView.sd_setImage(with: model.profilePicture, completed: nil)
    }
    
    @objc private func didTapButton() {
        delegate?.didTapDotButton()
    }
}
