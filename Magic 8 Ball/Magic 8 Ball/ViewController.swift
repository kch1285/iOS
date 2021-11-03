//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by chihoooon on 2021/11/03.
//

import UIKit

class ViewController: UIViewController {

    let ballArray = [#imageLiteral(resourceName: "ball1.png"),#imageLiteral(resourceName: "ball2.png"),#imageLiteral(resourceName: "ball3.png"),#imageLiteral(resourceName: "ball4.png"),#imageLiteral(resourceName: "ball5.png")]
    
    let askLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Ask Me Anything."
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let askButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ask", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        setUpAskLabel()
        setUpImageView()
        setUpAskButton()
    }
}

extension ViewController {
    private func setUpAskLabel() {
        let labelWidth: CGFloat = view.frame.size.width / 1.5
        askLabel.frame = CGRect(x: (view.frame.size.width - labelWidth) / 2, y: view.frame.size.height / 8, width: labelWidth, height: 100)
        view.addSubview(askLabel)
    }
    
    private func setUpImageView() {
        let imageSize: CGFloat = view.frame.size.width / 1.5
        imageView.frame = CGRect(x: (view.frame.size.width - imageSize) / 2, y: (view.frame.size.height - imageSize) / 2, width: imageSize, height: imageSize)
        view.addSubview(imageView)
    }
    
    private func setUpAskButton() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        askButton.frame = CGRect(x: (view.frame.size.width - buttonSize) / 2, y: view.frame.size.height / 4 * 3, width: buttonSize, height: buttonSize)
        askButton.addTarget(self, action: #selector(askButtonPressed), for: .touchUpInside)
        view.addSubview(askButton)
    }
    
    @objc private func askButtonPressed() {
        imageView.image = ballArray[Int.random(in: 0..<5)]
    }
}
