//
//  CalculateModel.swift
//  Calculator
//
//  Created by chihoooon on 2021/09/16.
//

import Foundation

class CalculateModel {
    private enum Operation {
        case UnaryOperation((Float) -> Float)
        case BinaryOperation((Float, Float) -> Float)
        case Equal
        case Clear(Float)
    }
    
    private struct BinaryOperationInfo {
        var binaryFunction: (Float, Float) -> Float
        var firstOperand: Float
    }
    
    private var accumulator: Float = 0.0
    private var operationInfo: BinaryOperationInfo?
    
    private var operations: [String: Operation] = [
        "+" : Operation.BinaryOperation({ $0 + $1}),
        "-" : Operation.BinaryOperation({ $0 - $1}),
        "x" : Operation.BinaryOperation({ $0 * $1}),
        "÷" : Operation.BinaryOperation({ $0 / $1}),
        "%" : Operation.UnaryOperation({ $0 * 0.01 }),
        "+/-" : Operation.UnaryOperation({ -$0 }),
        "=" : Operation.Equal,
        "AC" : Operation.Clear(0.0)
    ]
    
    var result: Float {
        get {
            return accumulator
        }
    }
    
    func setOperand(operand: Float) {
        accumulator = operand
    }
    
    func calculate(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                operationInfo = BinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equal:
                executePendingBinaryOperation()
            case .Clear(let value):
                accumulator = value
            }
        }
    }
    
    func executePendingBinaryOperation() {
        if let info = operationInfo {
            accumulator = info.binaryFunction(info.firstOperand, accumulator)
            operationInfo = nil
        }
    }
}
