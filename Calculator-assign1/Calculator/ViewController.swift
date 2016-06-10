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
    
    var userInTheMiddleOfTypingANumber = false
    var userTypingDecimalNumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        println("digit = \(digit)")
        
        if userTypingDecimalNumber && digit == "." {
            return;
        }
        
        if digit == "." {
            userTypingDecimalNumber = true
        }
        
        if userInTheMiddleOfTypingANumber{
            display.text = display.text! + digit
        }else {
            display.text = digit;
            userInTheMiddleOfTypingANumber = true;
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        userTypingDecimalNumber = false;
        operandStack.append( displayValue )
        
        displayHistory = displayHistory + " \(operandStack)"
        
        println("operandStack= \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false
            userTypingDecimalNumber = false;
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
    
    @IBAction func constant(sender: UIButton) {
        let constant = sender.currentTitle!
        
        switch constant {
            case "π" : operandStack.append( M_PI );
        default : break;
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
        //case "π" : perfromOperation { $0 * M_PI }
        case "sin" : perfromOperation { sin($0) }
        case "cos" : perfromOperation { cos($0) }
        default : break
        }
    }
    
    @IBOutlet weak var history: UILabel!
    
    var displayHistory : String {
        get {
            return history.text!;
        }
        set {
            history.text = newValue;
        }
    }
    
    @IBAction func clear() {
        operandStack = Array<Double>()
        userInTheMiddleOfTypingANumber = false;
        userTypingDecimalNumber = false;
        displayValue = 0;
        displayHistory = "";
        
    }
    
    
    
}



