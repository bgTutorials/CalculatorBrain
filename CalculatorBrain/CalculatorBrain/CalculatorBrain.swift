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
    
    func evaluate(var ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            let op = ops.removeLast()
        }
        
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    // FYI- when looking up Dictionaries in Swift, it always returns an Optional
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }

    // Access Control: what properties are public and private in this class. In Swift, you must specify which objects are to be private
    // @39' Structs in Swift: there are very close to Classes in Swift, but there are two significant differences-
    // First, Classes can inherit, Structs do not.
    // Second, Classes are passed by reference, Structs are passed by value (copied).
    
}