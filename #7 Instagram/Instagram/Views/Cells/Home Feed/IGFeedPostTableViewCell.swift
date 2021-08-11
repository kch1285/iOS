//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/04.
//

import UIKit
import SDWebImage
import AVFoundation

final class IGFeedPostTableViewCell: UITableViewCell {

    static let idenrifier = "IGFeedPostTableViewCell"
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
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
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        
        return
        switch post.postType {
        case .photo:
            postImageView.sd_setImage(with: post.postUrl, completed: nil)
        case .video:
            player = AVPlayer(url: post.postUrl)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
}
