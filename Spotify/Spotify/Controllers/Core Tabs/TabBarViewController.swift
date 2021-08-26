//
//  TabBarViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let libraryVC = LibraryViewController()
        let premiumVC = PremiumViewController()
        
        homeVC.navigationItem.title = "홈"
        searchVC.title = "검색하기"
        libraryVC.title = "내 라이브러리"
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        searchVC.navigationItem.largeTitleDisplayMode = .always
        libraryVC.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: searchVC)
        let nav3 = UINavigationController(rootViewController: libraryVC)
        let nav4 = UINavigationController(rootViewController: premiumVC)
        
        nav1.navigationBar.tintColor = .label
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "music.note.house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "검색하기", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "내 라이브러리", image: UIImage(systemName: "music.note.list"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "프리미엄", image: UIImage(systemName: "line.horizontal.3.decrease.circle.fill"), tag: 4)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }

}
