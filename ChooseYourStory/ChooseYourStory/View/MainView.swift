//
//  MainView.swift
//  ChooseYourStory
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func buttonPressed(_ button: UIButton)
}

class MainView: UIView {
    weak var delegate: MainViewDelegate?
    
    private let backgroundView: UIImageView = UIImageView(image: UIImage(named: "background"))
    
    let storyLabel: UILabel = {
        let label = UILabel()
        label.text = "Story Text"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    let firstChoiceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choice 1", for: .normal)
        button.setBackgroundImage(UIImage(named: "choice1Background"), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.tag = 1
        return button
    }()
    
    let secondChoiceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choice 2", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.setBackgroundImage(UIImage(named: "choice2Background"), for: .normal)
        button.tag = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayouts()
    }
    
    private func setUpViews() {
        addSubview(backgroundView)
        addSubview(storyLabel)
        addSubview(firstChoiceButton)
        addSubview(secondChoiceButton)
        
        firstChoiceButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        secondChoiceButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    private func setUpLayouts() {
        backgroundView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        storyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(frame.size.width / 10)
            make.trailing.equalToSuperview().offset(-frame.size.width / 10)
            make.height.equalTo(frame.size.height * 0.7)
        }
        
        firstChoiceButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(storyLabel)
            make.top.equalTo(storyLabel.snp.bottom).offset(10)
            make.height.equalTo((frame.size.height * 0.3 - 40) / 2)
        }
        
        secondChoiceButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(storyLabel)
            make.top.equalTo(firstChoiceButton.snp.bottom).offset(10)
            make.height.equalTo((frame.size.height * 0.3 - 40) / 2)
        }
    }
    
    @objc private func didTapButton(_ button: UIButton) {
        delegate?.buttonPressed(button)
    }
}
