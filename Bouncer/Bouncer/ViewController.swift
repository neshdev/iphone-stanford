//
//  ViewController.swift
//  Bouncer
//
//  Created by Dhinesh Kumar Devanathan on 5/29/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bouncer = BouncerBehavior()
    
    lazy var animator : UIDynamicAnimator = {
        UIDynamicAnimator(referenceView: self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator.addBehavior(bouncer)
        
    }
    
    struct Constants {
        static let BlockSize = CGSize(width: 40, height: 40)
    }
    
    
    var redBlock : UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if ( redBlock == nil) {
            redBlock = addBlock()
            redBlock?.backgroundColor = UIColor.redColor()
            bouncer.addblock(redBlock!)
        }
        let motionManager = AppDelegate.Motion.Manager
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (data, _) in
                self.bouncer.gravity.gravityDirection = CGVector(dx: (data?.acceleration.x)!, dy: (data?.acceleration.y)!)
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        AppDelegate.Motion.Manager.stopAccelerometerUpdates()
    }
    
    func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPoint.zero, size: Constants.BlockSize))
        block.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(block)
        return block
    }


}

