//
//  CalculatorBrain.swift
//  CalculatorBrain
//
//  Created by Brian J Glowe on 2/1/16.
//  Copyright © 2016 Brian Glowe. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op {
        // we can associated types with the data in an Enum. Here we have an Operand which has a type of Double
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String: Op]()
    
    init() {
        knownOps["×"] = Op.BinaryOperation("×") {$0 * $1 }
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0 }
        knownOps["+"] = Op.BinaryOperation("+") {$0 + $1 }
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0 }
        knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
    }
    
    // Through to 1 hour mark 
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    // FYI- when looking up Dictionaries in Swift, it always returns an Optional
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }

    // Access Control: what properties are public and private in this class. In Swift, you must specify which objects are to be private
    // @39' Structs in Swift: there are very close to Classes in Swift, but there are two significant differences-
    // First, Classes can inherit, Structs do not.
    // Second, Classes are passed by reference, Structs are passed by value (copied).
    
}