//
//  ViewController.swift
//  ChooseYourStory
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private var storyBrain = StroyBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMainViews()
    }

    private func setUpMainViews() {
        view.addSubview(mainView)
        mainView.delegate = self
        updateUI()
        mainView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func updateUI() {
        mainView.storyLabel.text = storyBrain.getStoryText()
        mainView.firstChoiceButton.setTitle(storyBrain.getChoiceButton()[0], for: .normal)
        mainView.secondChoiceButton.setTitle(storyBrain.getChoiceButton()[1], for: .normal)
    }
}


extension MainViewController: MainViewDelegate {
    func buttonPressed(_ button: UIButton) {
        let userChoice = button.tag
        storyBrain.checkUserChoice(userChoice)
        updateUI()
    }
    
}
