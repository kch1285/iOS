//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "내 마음에 꼭 드는 또 다른 플레이리스트를 발견해보세요."
        label.backgroundColor = .link
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let labelHeight: CGFloat = view.frame.height / 5
        welcomeLabel.frame = CGRect(x: 0, y: view.safeAreaInsets.top + labelHeight, width: view.frame.width, height: labelHeight)
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
