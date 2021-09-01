//
//  PlayerViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
}

class PlayerViewController: UIViewController {
    
    private let controlView = PlayerControlView()
    weak var dataSource: PlaybackPresenterDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        controlView.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(controlView)
        configureBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlView.frame = CGRect(x: 10, y: imageView.bottom + 10, width: view.width - 20, height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15)
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlView.configure(with: PlayerControlViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    
    private func configureBarButtons() {
        navigationController?.navigationBar.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(didTapAction))
    }

    func refreshUI() {
        configure()
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        
    }
}

//MARK: - PlayerControlViewDelegate

extension PlayerViewController: PlayerControlViewDelegate {
    func PlayerControlViewDidTapPlayPauseButton(_ view: PlayerControlView) {
        delegate?.didTapPlayPause()
    }
    
    func PlayerControlViewDidTapForwardButton(_ view: PlayerControlView) {
        delegate?.didTapForward()
    }
    
    func PlayerControlViewDidTapBackwardButton(_ view: PlayerControlView) {
        delegate?.didTapBackward()
    }
}
