//
//  ViewController.swift
//  Psychologist
//
//  Created by Dhinesh Kumar Devanathan on 5/6/16.
//  Copyright (c) 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var destination = segue.destinationViewController as? UIViewController
        
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        
        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "sad" : hvc.happiness = 0
                case "happy" : hvc.happiness = 100
                case "nothing" : hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }

    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: nil)
    }

}
