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
    
    var brain = CalculatorBrain()
    
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
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false;
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
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
    
    @IBAction func operate(sender: UIButton) {
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    
    
}



