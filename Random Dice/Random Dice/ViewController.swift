//
//  ViewController.swift
//  Random Dice
//
//  Created by chihoooon on 2021/11/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let imageSet = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceeLogo")
        return imageView
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GreenBackground")
        return imageView
    }()
    
    let firstDiceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceOne")
        imageView.alpha = 0.7
        return imageView
    }()
    
    let secondDiceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceOne")
        imageView.alpha = 0.7
        return imageView
    }()
    
    let rollButton: UIButton = {
        let button = UIButton()
        button.setTitle("굴리기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 30)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        setUpBackground()
        setUpLogo()
        setUpDice()
        setUpButton()
    }
}


extension ViewController {
    private func setUpDice() {
        let diceSize: CGFloat = 120
        view.addSubview(firstDiceImage)
        view.addSubview(secondDiceImage)
        
        firstDiceImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(view.frame.size.width / 8)
            make.width.equalTo(diceSize)
            make.height.equalTo(diceSize)
            make.centerY.equalToSuperview()
        }
        
        secondDiceImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-view.frame.size.width / 8)
            make.width.equalTo(diceSize)
            make.height.equalTo(diceSize)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setUpBackground() {
        backgroundImage.frame = view.bounds
        view.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func setUpLogo() {
        let logoSize: CGFloat = view.frame.size.height / 5
        view.addSubview(logoImage)
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(logoSize)
            make.height.equalTo(logoSize)
            make.top.equalToSuperview().offset(50)
        }
    }
    
    private func setUpButton() {
        let buttonWidth: CGFloat = view.frame.size.width / 2
        rollButton.addTarget(self, action: #selector(rollButtonPressed), for: .touchUpInside)
        view.addSubview(rollButton)
        
        rollButton.snp.makeConstraints { make in
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonWidth / 2)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-view.frame.height / 15)
        }
    }
    
    @objc private func rollButtonPressed() {
        firstDiceImage.image = imageSet[Int.random(in: 0..<6)]
        secondDiceImage.image = imageSet[Int.random(in: 0..<6)]
    }
}
