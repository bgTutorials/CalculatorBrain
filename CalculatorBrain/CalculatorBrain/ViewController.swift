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


// beginning at @31' - 34:30'
// We are going to take the operations out of the operate() and create new funcitons to share the code between each
    // differnt operation. We will declare the performOperation() as a type which take a function whose argumetns are 
    //two doubles and returns a double
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×": performOperation(multiply)
            case "÷": performOperation(divide)
            case "+": performOperation(addition)
//            case "−":
        default: break
        }
    }
    
//Let's try to go more DRY by sharing a function among the operations in the operate()
// WE CAN DO THAT BY DECLARING A FUNCTION AS A TYPE WHICH TAKE EACH INDIVIDUAL OPERATION FUNCTION
    
    //1. here we begin by declaring the performOperation() as a type: (Double, Double) -> Double
    // This function takes a function which has two arguments (each doubles) and returns a double
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    //2. Next each case of the operations are entered below, which the performOperation() will take as its arguments
    func multiply(op1: Double, op2:Double) ->Double {
        return op1 * op2
    }

    func divide(op1: Double, op2:Double) ->Double {
        return op1 / op2
    }

    func addition(op1: Double, op2:Double) ->Double {
        return op1 + op2
    }

//Now, the problem with the above solution, well, it is just a code heavy and again repeating alot of the same code.
    // while we are sharing some code, we are repeating much of the same again.
    
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









