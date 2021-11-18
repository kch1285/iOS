//
//  ViewController.swift
//  BMI
//
//  Created by chihoooon on 2021/11/18.
//

import UIKit

class CalculateViewController: UIViewController {

    private let calculateView = CalculateView()
    var height = 1.5
    var weight = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func heightUpdate(_ slider: UISlider) {
        calculateView.heightValueLabel.text = String(format: "%.2f", slider.value) + "m"
        guard let height = Double(String(format: "%.2f", slider.value)) else {
            return
        }
        self.height = height
    }
    
    func weightUpdate(_ slider: UISlider) {
        calculateView.weightValueLabel.text = "\(Int(slider.value))Kg"
        self.weight = Int(slider.value)
    }
    

    func calculate() {
        let bmi: Double
        if height == 0 {
            bmi = 0
        }
        else {
            bmi = Double(weight) / pow(height, 2)
        }
        print(bmi)
    }
}
