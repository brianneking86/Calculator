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
    
    var brain = CalculatorBrain()
    
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
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
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
    }
}

