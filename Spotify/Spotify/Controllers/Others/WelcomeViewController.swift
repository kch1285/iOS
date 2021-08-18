//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Spotify_Logo")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let SignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemGreen
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "내 마음에 꼭 드는 또 다른 플레이리스트를 발견해보세요."
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        SignInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        view.addSubview(welcomeLabel)
        view.addSubview(SignInButton)
        view.addSubview(logoImageView)
    }
    //view.height - 50 - view.safeAreaInsets.bottom
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let labelHeight: CGFloat = view.height / 5
        logoImageView.frame = CGRect(x: view.width / 2 - 40, y: view.safeAreaInsets.top + 80, width: 80, height: 80)
        welcomeLabel.frame = CGRect(x: 0, y: logoImageView.bottom + 80, width: view.width, height: labelHeight)
        SignInButton.frame = CGRect(x: 20, y: welcomeLabel.bottom + 100, width: view.width - 40, height: 50)
        
    }
    
    @objc private func didTapSignIn() {
        let vc = AuthViewController()
        vc.completion = { [weak self] success in
            DispatchQueue.main.async {
                self?.handelSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handelSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: nil, message: "Spotify 계정과 일치하지 않습니다. 다시 시도하세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
