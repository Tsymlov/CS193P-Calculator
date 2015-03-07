//
//  ViewController.swift
//  Calculator
//
//  Created by Alexey Tsymlov on 2/2/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()
    
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
        let operation = sender.currentTitle!;
        if userIsInTheMiddleOfTypingANumber {
            enter();
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                // error ?
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userAlredyPressedDot = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }else{
            // error?
            displayValue = 0 // task 2
        }
    }

    var displayValue :Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            userAlredyPressedDot = false
        }
    }
    
    var userAlredyPressedDot = false
    
    @IBAction func appendDot() {
        if userAlredyPressedDot{
            return
        }
        display.text = display.text! + "."
        userAlredyPressedDot = true
    }
}

