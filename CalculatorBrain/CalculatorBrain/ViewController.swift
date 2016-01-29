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


// beginning at @34:30' - 36:16'
//The good news is that it is so common to pass functions as arguments in Swift, you are able to put the function right into another function
    // rather than creating other (more) functions.
    // these are the beginning to closures
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
    //1. In swift we are able to put the operational functions we are using right into the arguments of the performOperation() parameters.
            // the only difference when passing a function as the argument of another funcion is we need to move the first { to just before the 
            // arguements are declared and replace it with the syntax "in"
        case "×": performOperation({ (op1: Double, op2:Double) -> Double in
            return op1 * op2
            })
            // this bit of syntax sweetness are called closures - when you pass a function directly into the argument of another function rather 
            // than declaring seperate functions. *Got that*
        case "÷": performOperation({ (op1: Double, op2:Double) -> Double in
            return op1 / op2
        })
        case "+": performOperation({ (op1: Double, op2:Double) -> Double in
            return op1 + op2
        })
//            case "−":
        default: break
        }
    }
    
    //2.The performOperation() remains the same
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
//This code is looking alot better than where we were in step 1. But because Swift has such strong Type Inference, we can still eliminate
    // code from those closure
    
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









