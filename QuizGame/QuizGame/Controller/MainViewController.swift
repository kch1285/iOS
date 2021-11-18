//
//  ViewController.swift
//  QuizGame
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private let mainView = MainView()
    private var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMainView()
    }

    private func setUpMainView() {
        view.addSubview(mainView)
        mainView.delegate = self
        updateUI()
        mainView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    @objc private func updateUI() {
        mainView.questionLabel.text = quizBrain.getQuestionText()
        mainView.firstChoiseButton.setTitle(quizBrain.getButtonTitle()[0], for: .normal)
        mainView.secondChoiseButton.setTitle(quizBrain.getButtonTitle()[1], for: .normal)
        mainView.thirdChoiseButton.setTitle(quizBrain.getButtonTitle()[2], for: .normal)
        
        mainView.firstChoiseButton.backgroundColor = .clear
        mainView.secondChoiseButton.backgroundColor = .clear
        mainView.thirdChoiseButton.backgroundColor = .clear
        
        mainView.progressView.progress = quizBrain.getProgress()
        mainView.scoreLabel.text = "Score : \(quizBrain.getScore())"
    }
}


extension MainViewController: MainViewDelegate {
    func buttonPressed(_ button: UIButton) {
        guard let userAnswer = button.currentTitle else {
            return
        }
        let result = quizBrain.checkAnswer(userAnswer)
        
        if result {
            button.backgroundColor = .green
        }
        else {
            button.backgroundColor = .red
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
}
