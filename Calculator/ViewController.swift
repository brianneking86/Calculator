//
//  ViewController.swift
//  Calculator
//
//  Created by Brianne King on 2/16/16.
//  Copyright © 2016 Brianne King. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var operandStack = Array<Double>()
    var operatorString = String()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        printHistory("\(displayValue)")
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        operatorString = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operatorString {
            case "✕": performOperation { $1 * $0 }
            case "÷": performOperation { $1 / $0 }
            case "+": performOperation { $1 + $0 }
            case "-": performOperation { $1 - $0 }
            case "√": performOperation { sqrt($0) }
            case "sin": performOperation { sin($0) }
            case "cos": performOperation { cos($0) }
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            printHistory(operatorString)
            enter()
        }
    }
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            printHistory(operatorString)
            enter()
        }
    }
    
    @IBAction func decimal(sender: UIButton) {
        if display.text!.rangeOfString(".") == nil { appendDigit(sender) }
    }
    
    
    @IBAction func piOperate() {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        displayValue = M_PI
        enter()
    }
    
    @IBAction func clearInput() {
        userIsInTheMiddleOfTypingANumber = false
        display.text = "0"
        history.text = ""
        operandStack.removeAll()
    }
    
    func printHistory(value: String) {
        history.text = history.text! + value
        history.text = history.text! + " "
    }
    
    
    
}

