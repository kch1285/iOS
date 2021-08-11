//
//  ExploreViewController.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import UIKit

class ExploreViewController: UIViewController {

    private var collectionView: UICollectionView?
    private var tabbedSearchCollectionView: UICollectionView?
    
    private var models = [UserPost]()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
        
        configureCollectionView()
        configureDimmedView()
        configureTabbedSearch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }
    
    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width / 3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        tabbedSearchCollectionView?.backgroundColor = .red
        
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
        }
        
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        
        view.addSubview(tabbedSearchCollectionView)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 4) / 3, height: (view.width - 4) / 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func configureDimmedView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCancel))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(gesture)

        view.addSubview(dimmedView)
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(test: "test")
      //  cell?.configure(with: )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabbedSearchCollectionView {
            return
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let user = User(userName: "강치훈", bio: "", name: (first: "", last: ""),
                        birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1),
                        joinedDate: Date(), profilePicture: URL(string: "www.naver.com")!)
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "www.naver.com")!,
                            postUrl: URL(string: "www.naver.com")!, caption: nil, likes: [], comments: [],
                            createdDate: Date(), taggedUsers: [], owner: user)
        
        let vc = PostViewController(model: post)
        vc.title = "탐색 탭"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didTapCancel()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancel))
        dimmedView.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.4
        }, completion: { done in
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        })
    }
    
    @objc private func didTapCancel() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        self.tabbedSearchCollectionView?.isHidden = true
        
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0
        }, completion: { done in
            if done {
                self.dimmedView.isHidden = true
            }
        })
    }
    
    private func query(_ text: String) {
        
    }
}
