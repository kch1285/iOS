//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/04.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridTab()
    func didTapTaggedTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.backgroundColor = .orange
        button.setBackgroundImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.backgroundColor = .orange
        button.setBackgroundImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
        addSubview(gridButton)
        addSubview(taggedButton)
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .label
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridTab()
    }
    
    @objc private func didTapTaggedButton() {
        taggedButton.tintColor = .label
        gridButton.tintColor = .lightGray
        delegate?.didTapTaggedTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = height - (Constants.padding * 2)
        let xPosition = ((width / 2) - size) / 2
        gridButton.frame = CGRect(x: xPosition, y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: xPosition + (width / 2), y: Constants.padding, width: size, height: size)
    }
}
