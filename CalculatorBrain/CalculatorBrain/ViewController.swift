//
//  ViewController.swift
//  CalculatorBrain
//
//  Created by Brian J Glowe on 1/13/16.
//  Copyright © 2016 Brian Glowe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBOutlet weak var display: UILabel!

// Fantastic explanation and demonstartion of closures in Stanford video #2 from 28'-40'
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        print("digit = \(digit)")
    }


// beginning at @37:11' - 40'
//Swift's powerful Type Inference allows eliminate the need to declare the types of the passed function's arguments (see: Double)
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        // 1. we dont need to express "return" because again Swift infers from the called function that it returns the operation
        case "×": performOperation({ (op1, op2) in op1 * op2 })
            
        //2. Swift does not force you to name the arguments (ie. op1 & op2), 
        //if you dont name them Swift will use the $0,$1,$2,$3... as the parameters ofthe argument
        // Note - the change in order of operations
        case "÷": performOperation({ $1 / $0 })
            
        //3. If it is the last argument of the function (performOperation() only has one argument,however) you can put the expression outside the parathesis.
        case "+": performOperation() { $0 + $1 }

        //4. And if it is the only argument passed to the function (as with performOperation()), we can delete the parenthesis entirely.
        case "−": performOperation { $1 - $0 }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

// Wow, that is some nice, concise code.
    
    var operandStack = [Double]()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        } set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}









