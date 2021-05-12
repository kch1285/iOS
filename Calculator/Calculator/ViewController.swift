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
        label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation: Operation?
    
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
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize * 3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.tag = 1
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        zeroButton.addTarget(self, action: #selector(zeroPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        for x in 0..<3{
            let layer1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 2), width: buttonSize, height: buttonSize))
            layer1.setTitleColor(.black, for: .normal)
            layer1.backgroundColor = .white
            layer1.setTitle("\(x + 1)", for: .normal)
            layer1.tag = x + 2
            layer1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(layer1)
        }
        
        for x in 0..<3{
            let layer2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 3), width: buttonSize, height: buttonSize))
            layer2.setTitleColor(.black, for: .normal)
            layer2.backgroundColor = .white
            layer2.setTitle("\(x + 4)", for: .normal)
            layer2.tag = x + 5
            layer2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(layer2)
        }
        
        for x in 0..<3{
            let layer3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 4), width: buttonSize, height: buttonSize))
            layer3.setTitleColor(.black, for: .normal)
            layer3.backgroundColor = .white
            layer3.setTitle("\(x + 7)", for: .normal)
            layer3.tag = x + 8
            layer3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(layer3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize * 5), width: view.frame.size.width - buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearPressed(_:)), for: .touchUpInside)
        holder.addSubview(clearButton)
        
        let operations = ["=", "+", "-", "x", "/"]
        for x in 0..<5{
            let operation = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height - (buttonSize * CGFloat(x + 1)), width: buttonSize, height: buttonSize))
            operation.setTitleColor(.white, for: .normal)
            operation.backgroundColor = .orange
            operation.setTitle(operations[x], for: .normal)
            operation.tag = x + 1
            operation.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            holder.addSubview(operation)
        }
        
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
        
    }
    
    @objc func clearPressed(_ sender: UIButton){
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
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
        if resultLabel.text == "0"{
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text{
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0{
            firstNumber = value
            resultLabel.text = "0"
        }
        if tag == 1{
            var secondNumber = 0
            if let text = resultLabel.text, let value = Int(text){
                secondNumber = value
            }
            if let operation = currentOperation{
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
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

