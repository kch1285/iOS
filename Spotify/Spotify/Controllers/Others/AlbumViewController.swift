//
//  AlbumViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/25.
//

import UIKit

class AlbumViewController: UIViewController {
    private let album: Album
    private var viewModels = [AlbumCollectionViewCellViewModel]()
    private var tracks = [AudioTrack]()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        
        return section
    }))
    
    init(album: Album){
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = album.name
        view.backgroundColor = .systemBackground
        
        collectionView.register(AlbumTrackCollectionViewCell.self, forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier)
        collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        fetchAlbums()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapActions))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func fetchAlbums() {
        APICaller.shared.getAlbumDetails(for: album) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.tracks = model.tracks.items
                    self?.viewModels = model.tracks.items.compactMap({
                        AlbumCollectionViewCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-")
                    })
                    self?.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc private func didTapActions() {
        let actionSheet = UIAlertController(title: album.name, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "앨범 저장하기", style: .default, handler: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            APICaller.shared.addAlbumToLibrary(album: strongSelf.album) { success in
                if success {
                    HapticsManager.shared.vibrate(for: .success)
                    NotificationCenter.default.post(name: .albumSavedNotification, object: nil)
                }
                else {
                    HapticsManager.shared.vibrate(for: .error)
                }
            }
        }))
        present(actionSheet, animated: true, completion: nil)
    }
}

//MARK: - CollectionView

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTrackCollectionViewCell.identifier, for: indexPath) as? AlbumTrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier, for: indexPath) as? PlaylistHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        let headerViewModel = PlaylistHeaderViewViewModel(name: album.name, ownerName: album.artists.first?.name, description: "앨범 발매 날짜 : \(album.release_date)", artworkURL: URL(string: album.images.first?.url ?? ""))
        
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        var track = tracks[indexPath.row]
        track.album = self.album
        PlaybackPresenter.shared.startPlayback(fron: self, track: track)
    }
}

//MARK: - PlaylistHeaderCollectionReusableViewDelegate

extension AlbumViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        let tracksWithAlbum: [AudioTrack] = tracks.compactMap({
            var track = $0
            track.album = self.album
            return track
        })
        
        PlaybackPresenter.shared.startPlayback(fron: self, tracks: tracksWithAlbum)
    }
}

