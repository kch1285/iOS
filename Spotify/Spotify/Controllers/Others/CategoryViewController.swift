//
//  CategoryViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/26.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let category: CategoryItem
    private var playlists = [Playlist]()
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        return NSCollectionLayoutSection(group: group)
    }))
    
    init(category: CategoryItem) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = category.name
        view.backgroundColor = .systemBackground
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeaturedPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistsCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        
        APICaller.shared.getCategoryPlaylists(category: category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.identifier, for: indexPath) as? FeaturedPlaylistsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let playlist = playlists[indexPath.row]
        
        cell.configure(with: FeaturedPlaylistsCellViewModel(name: playlist.name, artworkURL: URL(string: playlist.images.first?.url ?? ""), creatorName: playlist.owner.display_name))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = PlaylistViewController(playlist: playlists[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
