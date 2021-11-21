//
//  ResultViewController.swift
//  Tipsy
//
//  Created by chihoooon on 2021/11/21.
//

import UIKit

class ResultViewController: UIViewController {

    private let resultView = ResultView()
    var result = "0.0"
    var split = 0
    var tip = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpResultView()
    }
    
    private func setUpResultView() {
        view.addSubview(resultView)
        resultView.delegate = self
        resultView.resultLabel.text = result
        resultView.settingsLabel.text = "Split between \(split) people, with \(tip)% tip."
        resultView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

extension ResultViewController: ResultViewDelegate {
    func recalculate() {
        dismiss(animated: true, completion: nil)
    }
}
