//
//  ConnectingView.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/10.
//

import UIKit
import SnapKit

protocol ConnectingViewDelegate: AnyObject {
    func signOutButtonPressed()
}

class ConnectingView: UIView {
    
    weak var delegate: ConnectingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpAutoLayout()
    }
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private func setUpViews() {
        backgroundColor = UIColor(red: 57/255, green: 55/255, blue: 55/255, alpha: 1) //393737
        addSubview(signOutButton)
        signOutButton.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
    }
    
    private func setUpAutoLayout() {
        signOutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func didTapSignOutButton() {
        delegate?.signOutButtonPressed()
    }
}
