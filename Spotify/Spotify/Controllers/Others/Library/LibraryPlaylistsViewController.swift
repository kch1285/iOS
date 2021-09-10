//
//  LibraryPlaylistsViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/09/02.
//

import UIKit
import Foundation

class LibraryPlaylistsViewController: UIViewController {

    var playlists = [Playlist]()
    private let noPlaylistView = ActionLabelView()
    private var observer: NSObjectProtocol?
    public var selectionHandler: ((Playlist) -> Void)?
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setUpNoPlaylistView()
        fetchPlaylists()
        
        observer = NotificationCenter.default.addObserver(forName: .playlistCreatedNotification, object: nil, queue: .main, using: { [weak self] _ in
            self?.fetchPlaylists()
        })
        
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistView.center = view.center
        tableView.frame = view.bounds
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            noPlaylistView.isHidden = false
            tableView.isHidden = true
        }
        else {
            tableView.isHidden = false
            noPlaylistView.isHidden = true
            tableView.reloadData()
        }
    }
    
    private func setUpNoPlaylistView() {
        noPlaylistView.delegate = self
        noPlaylistView.configure(with: ActionLabelViewViewModel(text: "플레이리스트가 비어있습니다.", actionTitle: "생성하기"))
        view.addSubview(noPlaylistView)
    }
    
    public func fetchPlaylists() {
        playlists.removeAll()
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - ActionLabelViewDelegate

extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        let vc = CreatePlaylistViewController()
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}

//MARK: - tableView

extension LibraryPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: playlist.name, subtitle: playlist.owner.display_name, imageURL: URL(string: playlist.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        
        let playlist = playlists[indexPath.row]
        
        guard selectionHandler == nil else {
            selectionHandler?(playlist)
            dismiss(animated: true, completion: nil)
            return
        }
        
        let vc = PlaylistViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
    }
}