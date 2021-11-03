//
//  MainView.swift
//  Xylophone
//
//  Created by chihoooon on 2021/11/03.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func keyPressed(_ button: UIButton)
}

class MainView: UIView {
    
    public weak var delegate: MainViewDelegate?
    
    private let cKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitleColor(.label, for: .normal)
        button.setTitle("C", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
    }()
    
    private let dKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitleColor(.label, for: .normal)
        button.setTitle("D", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
    }()
    
    private let eKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitleColor(.label, for: .normal)
        button.setTitle("E", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
    }()
    
    private let fKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.label, for: .normal)
        button.setTitle("F", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
    }()
    
    private let gKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.label, for: .normal)
        button.setTitle("G", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
    }()
    
    private let aKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.label, for: .normal)
        button.setTitle("A", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
    }()
    
    private let bKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitleColor(.label, for: .normal)
        button.setTitle("B", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cKeyButton)
        addSubview(dKeyButton)
        addSubview(eKeyButton)
        addSubview(fKeyButton)
        addSubview(gKeyButton)
        addSubview(aKeyButton)
        addSubview(bKeyButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonMargin = (frame.size.height - (frame.size.height / 10 * 7)) / 8
        let sideMargin = 5
        cKeyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        dKeyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        eKeyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        fKeyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        gKeyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        aKeyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        bKeyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        
        cKeyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(buttonMargin * 1.5)
            make.height.equalTo(frame.size.height / 10)
            make.leading.equalToSuperview().offset(sideMargin)
            make.trailing.equalToSuperview().offset(-sideMargin)
        }
        
        dKeyButton.snp.makeConstraints { make in
            make.top.equalTo(cKeyButton.snp.bottom).offset(buttonMargin)
            make.height.equalTo(frame.size.height / 10)
            make.leading.equalToSuperview().offset(sideMargin * 2)
            make.trailing.equalToSuperview().offset(-sideMargin * 2)
        }
        
        eKeyButton.snp.makeConstraints { make in
            make.top.equalTo(dKeyButton.snp.bottom).offset(buttonMargin)
            make.height.equalTo(frame.size.height / 10)
            make.leading.equalToSuperview().offset(sideMargin * 3)
            make.trailing.equalToSuperview().offset(-sideMargin * 3)
        }
        
        fKeyButton.snp.makeConstraints { make in
            make.top.equalTo(eKeyButton.snp.bottom).offset(buttonMargin)
            make.height.equalTo(frame.size.height / 10)
            make.leading.equalToSuperview().offset(sideMargin * 4)
            make.trailing.equalToSuperview().offset(-sideMargin * 4)
        }
        
        gKeyButton.snp.makeConstraints { make in
            make.top.equalTo(fKeyButton.snp.bottom).offset(buttonMargin)
            make.height.equalTo(frame.size.height / 10)
            make.leading.equalToSuperview().offset(sideMargin * 5)
            make.trailing.equalToSuperview().offset(-sideMargin * 5)
        }
        
        aKeyButton.snp.makeConstraints { make in
            make.top.equalTo(gKeyButton.snp.bottom).offset(buttonMargin)
            make.height.equalTo(frame.size.height / 10)
            make.leading.equalToSuperview().offset(sideMargin * 6)
            make.trailing.equalToSuperview().offset(-sideMargin * 6)
        }
        
        bKeyButton.snp.makeConstraints { make in
            make.top.equalTo(aKeyButton.snp.bottom).offset(buttonMargin)
            make.height.equalTo(frame.size.height / 10)
            make.leading.equalToSuperview().offset(sideMargin * 7)
            make.trailing.equalToSuperview().offset(-sideMargin * 7)
        }
    }
    
    @objc private func keyPressed(_ button: UIButton) {
        delegate?.keyPressed(button)
    }
}
