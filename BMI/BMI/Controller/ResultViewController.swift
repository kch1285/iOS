//
//  ResultViewController.swift
//  BMI
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit

class ResultViewController: UIViewController {

    private let resultView = ResultView()
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpResultView()
    }
    
    private func setUpResultView() {
        resultView.bmiLabel.text = bmiValue
        resultView.backgroundColor = color
        resultView.adviceLabel.text = advice
        
        resultView.delegate = self
        view.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

extension ResultViewController: ResultViewDelegate {
    func recalculateButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
