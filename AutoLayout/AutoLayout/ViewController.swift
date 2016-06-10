//
//  ViewController.swift
//  AutoLayout
//
//  Created by Dhinesh Kumar Devanathan on 5/7/16.
//  Copyright (c) 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var secure : Bool = false {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func login() {
        
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    private func updateUI(){
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secure Password" : "Password"
    }
}

