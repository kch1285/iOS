//
//  ResultViewController.swift
//  BMI
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit

class ResultViewController: UIViewController {

    private let resultView = ResultView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpResultView() {
        view.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
