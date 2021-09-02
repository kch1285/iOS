//
//  LibraryViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit

class LibraryViewController: UIViewController {

    private let playlistsVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    private let toggleView = LibraryToggleView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        toggleView.delegate = self
        
        scrollView.contentSize = CGSize(width: view.width * 2, height: scrollView.height)
        
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        
        addChildren()
        updateBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 55)
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 50)
    }
    
    private func addChildren() {
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistsVC.didMove(toParent: self)
        
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumsVC.didMove(toParent: self)
    }
    
    private func updateBarButtons() {
        navigationController?.navigationBar.tintColor = .label
        switch toggleView.state {
        case .playlisdts:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddPlaylist))
        case .albums:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func didTapAddPlaylist() {
        let vc = CreatePlaylistViewController()
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}

//MARK: - UIScrollViewDelegate

extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= view.width - 100 {
            toggleView.update(for: .albums)
            updateBarButtons()
        }
        else {
            toggleView.update(for: .playlisdts)
            updateBarButtons()
        }
    }
}


//MARK: - LibraryToggleViewDelegate

extension LibraryViewController: LibraryToggleViewDelegate {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        updateBarButtons()
    }
    
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
}
