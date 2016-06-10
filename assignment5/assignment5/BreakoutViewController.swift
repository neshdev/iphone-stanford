//
//  BreakoutViewController.swift
//  assignment5
//
//  Created by Dhinesh Kumar Devanathan on 6/2/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class BreakoutViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    
    lazy var animator : UIDynamicAnimator = {
        let ga = UIDynamicAnimator(referenceView: self.gameView)
        return ga
    }()
    
    lazy var gravityBehavior : UIGravityBehavior = {
        let gb = UIGravityBehavior()
        return gb
    }()
    
    lazy var dynamicItemBehavior : UIDynamicItemBehavior = {
       var dib = UIDynamicItemBehavior()
        dib.allowsRotation = true;
        dib.elasticity = 1
        return dib
    }()
    
    lazy var colliderBehavior : UICollisionBehavior = {
        let cb = UICollisionBehavior()
        cb.translatesReferenceBoundsIntoBoundary = true
        return cb
    }()
    
    lazy var ball : Ball = {
        let rect = CGRect(x: (self.gameView.frame.size.width - 20) / 2, y: (self.gameView.frame.size.height - 20) / 2, width: 20, height: 20)
        let ball = Ball(frame: rect)
        ball.backgroundColor = UIColor.clearColor()
        return ball
    }()
    
    lazy var paddle : Paddle = {
        let rect = CGRectMake((self.gameView.frame.size.width - 120) / 2, self.gameView.frame.size.height - 80, 120, 20)
        let paddle = Paddle()
        paddle.frame = rect
        paddle.backgroundColor = UIColor.clearColor()
        return paddle
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
    }
    
    private func setup(){
        gameView.addSubview(paddle)
        gameView.addSubview(ball)
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(colliderBehavior)
        animator.addBehavior(dynamicItemBehavior)
        gravityBehavior.addItem(ball)
        colliderBehavior.addItem(ball)
        colliderBehavior.addItem(paddle)
        dynamicItemBehavior.addItem(ball)
        //colliderBehavior.addItem(westBoundary)
        //colliderBehavior.addItem(eastBoundary)
        //colliderBehavior.addItem(southBoundary)
        //colliderBehavior.addItem(northBoundary)
        
        
    }
}
