//
//  ViewController.swift
//  Random Dice
//
//  Created by chihoooon on 2021/11/01.
//

import UIKit

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
        firstDiceImage.frame = CGRect(x: 45, y: (view.frame.size.height - diceSize) / 2, width: diceSize, height: diceSize)
        secondDiceImage.frame = CGRect(x: view.frame.size.width - 45 - diceSize, y: (view.frame.size.height - diceSize) / 2, width: diceSize, height: diceSize)
        
        view.addSubview(firstDiceImage)
        view.addSubview(secondDiceImage)
    }
    
    private func setUpBackground() {
        backgroundImage.frame = view.bounds
        view.addSubview(backgroundImage)
    }
    
    private func setUpLogo() {
        let logoSize: CGFloat = view.frame.size.height / 5
        logoImage.frame = CGRect(x: (view.frame.size.width - logoSize) / 2, y: logoSize / 2, width: logoSize, height: logoSize)
        view.addSubview(logoImage)
    }
    
    private func setUpButton() {
        let buttonWidth: CGFloat = view.frame.size.width / 2
        rollButton.frame = CGRect(x: (view.frame.size.width - buttonWidth) / 2, y: (view.frame.size.height - buttonWidth / 2) / 1.25, width: buttonWidth, height: buttonWidth / 2)
        
        rollButton.addTarget(self, action: #selector(rollButtonPressed), for: .touchUpInside)
        view.addSubview(rollButton)
    }
    
    @objc private func rollButtonPressed() {
        firstDiceImage.image = imageSet[Int.random(in: 0..<6)]
        secondDiceImage.image = imageSet[Int.random(in: 0..<6)]
    }
}
