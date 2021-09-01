//
//  PlayerControlView.swift
//  Spotify
//
//  Created by chihoooon on 2021/09/01.
//

import UIKit

protocol PlayerControlViewDelegate: AnyObject {
    func PlayerControlViewDidTapPlayPauseButton(_ view: PlayerControlView)
    func PlayerControlViewDidTapForwardButton(_ view: PlayerControlView)
    func PlayerControlViewDidTapBackwardButton(_ view: PlayerControlView)
}

struct PlayerControlViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlView: UIView {
    
    weak var delegate: PlayerControlViewDelegate?
    private var isPlaying = true
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
       // addSubview(volumeSlider)
        backwardButton.addTarget(self, action: #selector(didTapBackward), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapForward), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(backwardButton)
        addSubview(forwardButton)
        addSubview(playPauseButton)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize: CGFloat = 80
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom + 5, width: width, height: 20)
        playPauseButton.frame = CGRect(x: (width - buttonSize) / 2, y: subtitleLabel.bottom + 10, width: buttonSize, height: buttonSize)
        backwardButton.frame = CGRect(x: playPauseButton.left - 30 - buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        forwardButton.frame = CGRect(x: playPauseButton.right + 30, y: playPauseButton.top, width: buttonSize, height: buttonSize)
    }
    
    @objc private func didTapBackward() {
        delegate?.PlayerControlViewDidTapBackwardButton(self)
    }
    
    @objc private func didTapForward() {
        delegate?.PlayerControlViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.PlayerControlViewDidTapPlayPauseButton(self)
        let play = UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64, weight: .regular))
        let pause = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64, weight: .regular))
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    func configure(with viewModel: PlayerControlViewViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
