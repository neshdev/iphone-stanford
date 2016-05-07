//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Dhinesh Kumar Devanathan on 5/7/16.
//  Copyright (c) 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class  DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate
{
    override var happiness : Int {
        didSet{
            diagnosticsHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticsHistory : [Int] {
        get {
            return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? []
        }
        set {
            defaults.setObject(newValue, forKey: History.DefaultsKey)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessVC.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch id{
            case History.SegueIdentifier :
                if let tvc = segue.destinationViewController     as? TextViewController  {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticsHistory)"
                }
            default : break
            }
        }
    }
    
}
