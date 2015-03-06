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
        switch operation {
        case "×": performOperation{$0 * $1}
        case "÷": performOperation{$1 / $0}
        case "+": performOperation{$0 + $1}
        case "−": performOperation{$1 - $0}
        case "√": performOperation{sqrt($0)}
        case "sin": performOperation{sin($0)}
        case "cos": performOperation{cos($0)}
        case "π": performPiOperation()
        default: break
        }
        history.text! += operation
    }
    
    func performOperation (operation: Double -> Double){
        if operandStack.count >= 1 {
        displayValue = operation( operandStack.removeLast())
        enter()
        }
    }
    
    func performOperation (operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation( operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performPiOperation(){
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        displayValue = M_PI
        userAlredyPressedDot = true
        enter()
    }
    
    var operandStack = Array <Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userAlredyPressedDot = false
        operandStack.append( displayValue )
        println("operandStack = \(operandStack)")
        history.text! += display.text!
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

