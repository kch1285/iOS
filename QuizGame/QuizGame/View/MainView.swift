//
//  MainView.swift
//  QuizGame
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
    
    private let backgroundImage: UIImageView = UIImageView(image: UIImage(named: "Background-Bubbles"))
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Score : "
        return label
    }()
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question Text"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    let firstChoiseButton: UIButton = {
        let button = UIButton()
        button.setTitle("first", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        return button
    }()
    
    let secondChoiseButton: UIButton = {
        let button = UIButton()
        button.setTitle("second", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        return button
    }()
    
    let thirdChoiseButton: UIButton = {
        let button = UIButton()
        button.setTitle("third", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        return button
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(red: 1, green: 117/255, blue: 168/255, alpha: 1)
        progressView.trackTintColor = .white
        progressView.progress = 0.5
        progressView.progressViewStyle = .bar
        return progressView
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
        layoutViews()
    }
    
    private func setUpViews() {
        backgroundColor = UIColor(red: 37/255, green: 44/255, blue: 74/255, alpha: 1)
        addSubview(backgroundImage)
        addSubview(scoreLabel)
        addSubview(questionLabel)
        addSubview(firstChoiseButton)
        addSubview(secondChoiseButton)
        addSubview(thirdChoiseButton)
        addSubview(progressView)
        
        firstChoiseButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        secondChoiseButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        thirdChoiseButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    private func layoutViews() {
        backgroundImage.snp.makeConstraints { make in
            make.leading.width.bottom.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 10)
            make.top.equalToSuperview().offset(frame.size.height / 10)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(frame.size.width / 10)
            make.trailing.equalToSuperview().offset(-frame.size.width / 10)
            make.top.equalToSuperview()
            make.height.equalTo(frame.size.height * 0.5)
        }
        
        firstChoiseButton.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(questionLabel)
        }
        
        secondChoiseButton.snp.makeConstraints { make in
            make.top.equalTo(firstChoiseButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(questionLabel)
        }
        
        thirdChoiseButton.snp.makeConstraints { make in
            make.top.equalTo(secondChoiseButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(questionLabel)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(thirdChoiseButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(questionLabel)
        }
    }
    
    @objc private func didTapButton(_ button: UIButton) {
        delegate?.buttonPressed(button)
    }
}
