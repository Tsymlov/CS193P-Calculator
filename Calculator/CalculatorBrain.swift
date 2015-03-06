//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Alexey Tsymlov on 3/6/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String : Op]()
    
    init(){
        knownOps["×"] = Op.BinaryOperation("×", * )
        knownOps["+"] = Op.BinaryOperation("+", + )
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
        knownOps["-"] = Op.BinaryOperation("-") { $1 - $0 }
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        
    }
    
    func evaluate () -> Double? {
    
    }
}