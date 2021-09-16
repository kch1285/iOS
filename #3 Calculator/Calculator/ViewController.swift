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
    
    private var displayValue: Float {
        get {
            guard let digit = resultLabel.text else {
                return 0.0
            }
            
            return Float(digit)!
        }
        set {
            resultLabel.text = String(newValue)
        }
    }
    
    private var model = CalculateModel()
    private var maxCount: Int = 8
    private var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNumberPad()
    }
    
    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize * 2, height: buttonSize))
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.tag = 1
        zeroButton.backgroundColor = .darkGray
        zeroButton.setTitle("0", for: .normal)
        zeroButton.titleLabel?.font = .systemFont(ofSize: 30)
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        let dotButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - buttonSize, width: buttonSize, height: buttonSize))
        
        dotButton.setTitleColor(.white, for: .normal)
        dotButton.backgroundColor = .darkGray
        dotButton.setTitle(".", for: .normal)
        dotButton.titleLabel?.font = .systemFont(ofSize: 30)
        dotButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
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
        acButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        holder.addSubview(acButton)
        
        let plusMinusButton = UIButton(frame: CGRect(x: buttonSize, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        plusMinusButton.setTitleColor(.black, for: .normal)
        plusMinusButton.backgroundColor = .lightGray
        plusMinusButton.setTitle("+/-", for: .normal)
        plusMinusButton.titleLabel?.font = .systemFont(ofSize: 30)
        plusMinusButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        holder.addSubview(plusMinusButton)
        
        let percentButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
        percentButton.setTitleColor(.black, for: .normal)
        percentButton.backgroundColor = .lightGray
        percentButton.setTitle("%", for: .normal)
        percentButton.titleLabel?.font = .systemFont(ofSize: 30)
        percentButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
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
    
    @objc private func numberPressed(_ sender: UIButton){
        guard let digit = sender.currentTitle else {
            return
        }
        if isTyping {
            if let currentDigits = resultLabel.text,
               let count = resultLabel.text?.count, count < maxCount {
                resultLabel.text = currentDigits + digit
            }
        }
        else {
            resultLabel.text = digit
        }
        isTyping = true
    }
    
    @objc private func operationPressed(_ sender: UIButton){
        if isTyping {
            model.setOperand(operand: displayValue)
            isTyping = false
        }
        
        if let symbol = sender.currentTitle {
            model.calculate(symbol: symbol)
        }
        
        if String(model.result).contains(".") {
            maxCount += 1
        }
        
        if String(model.result).contains("-") {
            maxCount += 1
        }
        
        print(model.result)
        print(String(model.result).count)
        if String(model.result).count < maxCount {
            displayValue = model.result
        }
        else {
            resultLabel.text = "ERR"
        }
        maxCount = 8
    }
}

