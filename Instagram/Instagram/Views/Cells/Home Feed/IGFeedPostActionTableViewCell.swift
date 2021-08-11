//
//  IGFeedPostActionTableViewCell.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/04.
//

import UIKit

protocol IGFeedPostActionTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class IGFeedPostActionTableViewCell: UITableViewCell {

    static let idenrifier = "IGFeedPostActionTableViewCell"
    public weak var delegate: IGFeedPostActionTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
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

        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(commentButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height - 15
        let buttons = [likeButton, commentButton, sendButton]
        
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: CGFloat(x) * size + CGFloat(x + 1) * 3, y: 7.5, width: size, height: size)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton() {
        delegate?.didTapSendButton()
    }
    
    public func configure(with post: UserPost) {
        
    }

}
