//
//  BMIBrain.swift
//  BMI
//
//  Created by chihoooon on 2021/11/20.
//

import UIKit

struct BMIBrain {
    var bmi: BMI?
    
    mutating func calculateBMI(height: Double, weight: Int) {
        var bmiValue: Double
        if height == 0 {
            bmiValue = 0
        }
        else {
            bmiValue = Double(weight) / pow(height, 2)
        }
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "마름!", color: .systemBlue)
        }
        else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "적정!", color: .systemGreen)
        }
        else {
            bmi = BMI(value: bmiValue, advice: "돼지!", color: .systemRed)
        }
    }
    
    func getBMIValue() -> String {
        let bmiValue = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiValue
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? ""
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .systemBackground
    }
}
