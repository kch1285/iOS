//
//  PayWallViewController.swift
//  Thoughts
//
//  Created by chihoooon on 2021/08/13.
//

import UIKit

class PayWallViewController: UIViewController {

    private let header = PayWallHeaderView()
    private let descriptView = PayWallDescriptionView()
    
    private let termsView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .secondaryLabel
        textView.text = "구독 취소할 때까지 요금제가 자동 갱신됩니다."
        return textView
    }()
    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("구독하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("구독 취소", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "프리미엄 결제"
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        view.addSubview(subscribeButton)
        view.addSubview(restoreButton)
        view.addSubview(termsView)
        view.addSubview(descriptView)
        setUpButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height / 3)
        termsView.frame = CGRect(x: 10, y: view.height - 100, width: view.width - 20, height: 100)
        restoreButton.frame = CGRect(x: 25, y: termsView.top - 70, width: view.width - 50, height: 50)
        subscribeButton.frame = CGRect(x: 25, y: restoreButton.top - 70, width: view.width - 50, height: 50)
        descriptView.frame = CGRect(x: 0, y: header.bottom, width: view.width, height: subscribeButton.top - view.safeAreaInsets.top - header.height)
    }
    
    private func setUpButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        subscribeButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }
    
    @objc private func didTapSubscribe() {
        
    }
    
    @objc private func didTapRestore() {
        
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
