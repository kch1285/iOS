//
//  TabBarViewController.swift
//  Thoughts
//
//  Created by chihoooon on 2021/08/11.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpControllers()
    }

    private func setUpControllers() {
        let home = HomeViewController()
        home.title = "메인"
        let profile = ProfileViewController()
        profile.title = "프로필"
        
        home.navigationItem.largeTitleDisplayMode = .always
        profile.navigationItem.largeTitleDisplayMode = .always
        
        let homeNav = UINavigationController(rootViewController: home)
        let profileNav = UINavigationController(rootViewController: profile)
        
        homeNav.tabBarItem = UITabBarItem(title: "메인", image: UIImage(systemName: "house"), tag: 1)
        profileNav.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person"), tag: 2)
        
        homeNav.navigationBar.prefersLargeTitles = true
        profileNav.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNav, profileNav], animated: true)
    }
}
