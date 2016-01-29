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


// @30:45 - Here the operate() is providing the operations we need, but this is very sloppy code and NOT 
    // DRY. If someone was to read this code, they would laugh at how poor of programmers I am
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() * operandStack.removeLast()
                    enter()
            }
            case "÷":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() / operandStack.removeLast()
                    enter()
            }
            case "+":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() + operandStack.removeLast()
                    enter()
            }
            case "−":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() - operandStack.removeLast()
                    enter()
            }
        default: break
        }
    }
    
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

