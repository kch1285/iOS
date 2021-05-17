//
//  ViewController.swift
//  Calculator
//
//  Created by chihoooon on 2021/05/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var holder: UIView!
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 50)
        return label
    }()
    
    var firstNumber: Float = 0
    var secondNumber: Float = 0
    
    var currentOperation: Operation?
    var signFlag: Bool = true
    var dotFlag: Bool = false
    var maxCount: Int = 8
    var errFlag: Bool = false
    var continuousFlag: Bool = false
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNumberPad()
    }
    
    private func setupNumberPad(){
        let buttonSize: CGFloat = view.frame.size.width / 4
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize * 2, height: buttonSize))
        zeroButton.layer.borderWidth = 2
        zeroButton.layer.borderColor = UIColor.red.cgColor
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.tag = 1
        zeroButton.backgroundColor = .darkGray
        zeroButton.setTitle("0", for: .normal)
        zeroButton.titleLabel?.font = .systemFont(ofSize: 30)
        zeroButton.addTarget(self, action: #selector(zeroPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        let dotButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - buttonSize, width: buttonSize, height: buttonSize))
        
        dotButton.setTitleColor(.white, for: .normal)
        dotButton.backgroundColor = .darkGray
        dotButton.setTitle(".", for: .normal)
        dotButton.titleLabel?.font = .systemFont(ofSize: 30)
        dotButton.addTarget(self, action: #selector(dotPressed(_:)), for: .touchUpInside)
        holder.addSubview(dotButton)
        
        for x in 0..<3{
            let layer1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 2), width: buttonSize, height: buttonSize))
            
            layer1.setTitleColor(.white, for: .normal)
            layer1.backgroundColor = .darkGray
            layer1.setTitle("\(x + 1)", for: .normal)
            layer1.titleLabel?.font = .systemFont(ofSize: 30)
            layer1.tag = x + 2
            layer1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(layer1)
        }
        
        for x in 0..<3{
            let layer2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 3), width: buttonSize, height: buttonSize))
            
            layer2.setTitleColor(.white, for: .normal)
            layer2.backgroundColor = .darkGray
            layer2.setTitle("\(x + 4)", for: .normal)
            layer2.titleLabel?.font = .systemFont(ofSize: 30)
            layer2.tag = x + 5
            layer2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(layer2)
        }
        
        for x in 0..<3{
            let layer3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 4), width: buttonSize, height: buttonSize))
            layer3.setTitleColor(.white, for: .normal)
            layer3.backgroundColor = .darkGray
            layer3.setTitle("\(x + 7)", for: .normal)
            layer3.titleLabel?.font = .systemFont(ofSize: 30)
            layer3.tag = x + 8
            layer3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(layer3)
        }
        
        let acButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        acButton.setTitleColor(.black, for: .normal)
        acButton.backgroundColor = .lightGray
        acButton.setTitle("AC", for: .normal)
        acButton.titleLabel?.font = .systemFont(ofSize: 30)
        acButton.addTarget(self, action: #selector(clearPressed(_:)), for: .touchUpInside)
        holder.addSubview(acButton)
        
        let plusMinusButton = UIButton(frame: CGRect(x: buttonSize, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        plusMinusButton.setTitleColor(.black, for: .normal)
        plusMinusButton.backgroundColor = .lightGray
        plusMinusButton.setTitle("+/-", for: .normal)
        plusMinusButton.titleLabel?.font = .systemFont(ofSize: 30)
        plusMinusButton.addTarget(self, action: #selector(plusMinusPressed(_:)), for: .touchUpInside)
        holder.addSubview(plusMinusButton)
        
        let percentButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        percentButton.setTitleColor(.black, for: .normal)
        percentButton.backgroundColor = .lightGray
        percentButton.setTitle("%", for: .normal)
        percentButton.titleLabel?.font = .systemFont(ofSize: 30)
        percentButton.addTarget(self, action: #selector(percentPressed(_:)), for: .touchUpInside)
        holder.addSubview(percentButton)
        
        let operations = ["=", "+", "-", "x", "÷"]
        for x in 0..<5{
            let operation = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height - (buttonSize * CGFloat(x + 1)), width: buttonSize, height: buttonSize))
            operation.setTitleColor(.white, for: .normal)
            operation.backgroundColor = .orange
            operation.setTitle(operations[x], for: .normal)
            operation.titleLabel?.font = .systemFont(ofSize: 30)
            operation.tag = x + 1
            operation.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            holder.addSubview(operation)
        }
        
        resultLabel.frame = CGRect(x: 20, y: holder.frame.size.height - (buttonSize * 5) - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
        
    }
    
    @objc func clearPressed(_ sender: UIButton){
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
        signFlag = true
        dotFlag = false
        errFlag = false
        continuousFlag = false
        maxCount = 8
    }
    
    @objc func plusMinusPressed(_ sender: UIButton){
        if let text = resultLabel.text{
            if signFlag{
                resultLabel.text = "-" + text
                signFlag = false
                maxCount += 1
            }
            else{
                resultLabel.text = text.trimmingCharacters(in: ["-"])
                signFlag = true
                maxCount -= 1
            }
        }
    }
    
    @objc func percentPressed(_ sender: UIButton){
        if let text = resultLabel.text, var value = Float(text){
            value = value * 0.01
            resultLabel.text = "\(value)"
            dotFlag = true
            maxCount += 1
        }
    }
    
    @objc func dotPressed(_ sender: UIButton){
        if let text = resultLabel.text{
            if !dotFlag{
                resultLabel.text = text + "."
                dotFlag = true
                maxCount += 1
            }
        }
    }
    
    @objc func zeroPressed(_ sender: UIButton){
        if resultLabel.text != "0"{
            if let text = resultLabel.text{
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @objc func numberPressed(_ sender: UIButton){
        let tag = sender.tag - 1
        if let count = resultLabel.text?.count{
            if count < maxCount{
                if signFlag{
                    if resultLabel.text == "0"{
                        resultLabel.text = "\(tag)"
                    }
                    
                    else if let text = resultLabel.text{
                        resultLabel.text = "\(text)\(tag)"
                    }
                }
                else{
                    if resultLabel.text == "-0"{
                        resultLabel.text = "-" + "\(tag)"
                    }
                    
                    else if let text = resultLabel.text{
                        resultLabel.text = "\(text)\(tag)"
                    }
                }
            }
            
        }
        
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        if !errFlag{
            if let text = resultLabel.text, let value = Float(text), firstNumber == 0{
                firstNumber = value
                resultLabel.text = "0"
                signFlag = true
                dotFlag = false
            }
            if tag == 1{
                if !continuousFlag{
                    if let text = resultLabel.text, let value = Float(text){
                        secondNumber = value
                    }
                    continuousFlag = true
                }
                
                if let operation = currentOperation{
                    switch operation {
                    case .add:
                        let result = firstNumber + secondNumber
                        let count = String(result).count
                        if count > maxCount{
                            errFlag = true
                            resultLabel.text = "ERR"
                        }
                        else{
                            firstNumber = result
                            if result == Float(Int(result)){
                                let toInt = Int(result)
                                resultLabel.text = "\(toInt)"
                            }
                            else{
                                resultLabel.text = "\(result)"
                            }
                        }
                        break
                    case .subtract:
                        let result = firstNumber - secondNumber
                        let count = String(result).count
                        if count > maxCount{
                            errFlag = true
                            resultLabel.text = "ERR"
                        }
                        else{
                            firstNumber = result
                            if result == Float(Int(result)){
                                let toInt = Int(result)
                                resultLabel.text = "\(toInt)"
                            }
                            else{
                                resultLabel.text = "\(result)"
                            }
                        }
                        break
                    case .multiply:
                        let result = firstNumber * secondNumber
                        let count = String(result).count
                        if count > maxCount{
                            errFlag = true
                            resultLabel.text = "ERR"
                        }
                        else{
                            firstNumber = result
                            if result == Float(Int(result)){
                                let toInt = Int(result)
                                resultLabel.text = "\(toInt)"
                            }
                            else{
                                resultLabel.text = "\(result)"
                            }
                        }
                        break
                    case .divide:
                        let result = firstNumber / secondNumber
                        let count = String(result).count
                        if count > maxCount{
                            errFlag = true
                            resultLabel.text = "ERR"
                        }
                        else{
                            firstNumber = result
                            if result == Float(Int(result)){
                                let toInt = Int(result)
                                resultLabel.text = "\(toInt)"
                            }
                            else{
                                resultLabel.text = "\(result)"
                            }
                        }
                        break
                    }
                }
            }
            else if tag == 2{
                currentOperation = .add
            }
            else if tag == 3{
                currentOperation = .subtract
            }
            else if tag == 4{
                currentOperation = .multiply
            }
            else if tag == 5{
                currentOperation = .divide
            }
        }
    }
}

