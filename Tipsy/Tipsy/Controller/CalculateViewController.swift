//
//  ViewController.swift
//  Tipsy
//
//  Created by chihoooon on 2021/11/21.
//

import UIKit

class CalculateViewController: UIViewController {

    private let calculateView = CalculateView()
    var bill: Double = 0.0
    var tip: Double = 0.1
    var numberOfPeople: Int = 2
    var result = 0.0
    var finalResult = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCalculateView()
    }


    private func setUpCalculateView() {
        view.addSubview(calculateView)
        calculateView.delegate = self
        calculateView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

extension CalculateViewController: CalculateViewDelegate {
    func calculate(splitNumber: String) {
        numberOfPeople = Int(splitNumber)!
        guard let text = calculateView.billtextField.text else {
            return
        }
        bill = Double(text) ?? 0.0
        result = bill * (1 + tip) / Double(numberOfPeople)
        finalResult = String(format: "%.2f", result)
        
        let resultVC = ResultViewController()
        resultVC.result = finalResult
        resultVC.split = numberOfPeople
        resultVC.tip = Int(tip)
        present(resultVC, animated: true, completion: nil)
    }
    
    func stepperChanged(_ stepper: UIStepper) {
        calculateView.splitNumberLabel.text = String(Int(stepper.value))
    }
    
    func tipChanged(_ tip: UIButton) {
        guard let percent = tip.titleLabel?.text else {
            return
        }
        
        guard let tipValue = Double(percent.dropLast()) else {
            return
        }
        
        self.tip = tipValue
    }
}
