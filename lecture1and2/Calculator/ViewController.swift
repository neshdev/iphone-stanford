//
//  ViewController.swift
//  Calculator
//
//  Created by Dhinesh Kumar Devanathan on 4/26/16.
//  Copyright (c) 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTypingANumber = false;
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!;
        println("digit = \(digit)");
        if userInTheMiddleOfTypingANumber{
            display.text = display.text! + digit;
        }else {
            display.text = digit;
            userInTheMiddleOfTypingANumber = true;
        }
        
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false;
        operandStack.append( displayValue );
        println("operandStack= \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false;
        }
    }
    
    func perfromOperation(operation: (Double, Double) -> Double){
        if ( operandStack.count >= 2 )
        {
            displayValue = operation( operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func perfromOperation(operation: Double -> Double){
        if ( operandStack.count >= 1 )
        {
            displayValue = operation( operandStack.removeLast())
            enter()
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        
        switch operation {
            case "×" : perfromOperation { $0 * $1 }
            case "÷" : perfromOperation { $1 / $0 }
            case "+" : perfromOperation { $0 + $1 }
            case "-" : perfromOperation { $1 - $0 }
            case "√" : perfromOperation { sqrt($0) }
            default : break
        }
    }
    
    
    
}



