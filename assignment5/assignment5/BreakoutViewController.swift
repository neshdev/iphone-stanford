//
//  BreakoutViewController.swift
//  assignment5
//
//  Created by Dhinesh Kumar Devanathan on 6/2/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class BreakoutViewController: UIViewController {
    
    lazy var animator : UIDynamicAnimator = {
        let ga = UIDynamicAnimator(referenceView: self.view)
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
        return cb
    }()
    
//    lazy var ball : Ball = {
//        let rect = CGRectMake(0, 0, BallConstants.width, BallConstants.height)
//        let ball = Ball(frame: rect)
//        ball.backgroundColor = UIColor.clearColor()
//        return ball
//    }()
    
    private var ball : Ball?
    private var paddle : Paddle?
    
//    private func positionBall(){
//        let rect = CGRect(x: (self.gameView.frame.size.width - BallConstants.width) / 2, y: (self.gameView.frame.size.height - BallConstants.height) / 2, width: BallConstants.width, height: BallConstants.height)
//        
//        print("positionBall: \(rect)")
//        
//        ball.frame = rect
//    }
    
//    lazy var paddle : Paddle = {
//        let rect = CGRectMake(0, 0, PaddleConstants.width, PaddleConstants.height)
//        let paddle = Paddle(frame: rect)
//        paddle.backgroundColor = UIColor.clearColor()
//        return paddle
//        
//    }()
//    
//    private func positionPaddle(){
//        let rect = CGRect(x: (self.gameView.frame.size.width - PaddleConstants.width) / 2, y: self.gameView.frame.size.height - PaddleConstants.height, width: PaddleConstants.width, height: PaddleConstants.height)
//        
//        print("positionPaddle: \(rect)")
//        
//        paddle.frame = rect
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inializeSubViews()
        initalizeAnimations()
        //positionBall()
        //positionPaddle()
        addBarriers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    private func inializeSubViews(){
        let ballRect = CGRect(x: (self.view.frame.size.width - BallConstants.width) / 2, y: (self.view.frame.size.height - BallConstants.height) / 2, width: BallConstants.width, height: BallConstants.height)
        let b = Ball(frame: ballRect)
        b.backgroundColor = UIColor.clearColor()
        
        let paddleRect = CGRect(x: (self.view.frame.size.width - PaddleConstants.width) / 2, y: self.view.frame.size.height - PaddleConstants.height, width: PaddleConstants.width, height: PaddleConstants.height)
        let p = Paddle(frame: paddleRect)
        p.backgroundColor = UIColor.clearColor()
        
        self.ball = b
        self.paddle = p
        
        self.view.addSubview(paddle!)
        self.view.addSubview(ball!)
    }
    
    private func initalizeAnimations(){
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(colliderBehavior)
        animator.addBehavior(dynamicItemBehavior)
        gravityBehavior.addItem(ball!)
        colliderBehavior.addItem(ball!)
        colliderBehavior.addItem(paddle!)
        dynamicItemBehavior.addItem(ball!)
    }
    
    private func addBarriers(){
        let tl = CGPoint(x: self.view.frame.minX, y: self.view.frame.minY)
        print("tl: \(tl)")
        let tr = CGPoint(x: self.view.frame.maxX, y: self.view.frame.minY)
        print("tr: \(tr)")
        let br = CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY)
        print("br: \(br)")
        let bl = CGPoint(x: self.view.frame.minX, y: self.view.frame.maxY)
        print("bl: \(bl)")
        
        self.colliderBehavior.removeAddBoundaryWithIdentifier(WallConstants.north, fromPoint: tl, toPoint: tr)
        self.colliderBehavior.removeAddBoundaryWithIdentifier(WallConstants.east, fromPoint: tr, toPoint: br)
        self.colliderBehavior.removeAddBoundaryWithIdentifier(WallConstants.west, fromPoint: bl, toPoint: tl)
        self.colliderBehavior.removeAddBoundaryWithIdentifier(WallConstants.south, fromPoint: bl, toPoint: br)
    }
    
    
    
    class WallConstants {
        static let north = "North"
        static let east = "East"
        static let south = "South"
        static let west = "West"
    }
    
    class BallConstants {
        static let height =  CGFloat(20)
        static let width = CGFloat(20)
    }
    
    class PaddleConstants {
        static let height = CGFloat(20)
        static let width =  CGFloat(120)
    }
    
}

extension UICollisionBehavior {
    func removeAddBoundaryWithIdentifier(identifier: NSCopying, fromPoint: CGPoint, toPoint: CGPoint) {
        self.removeBoundaryWithIdentifier(identifier)
        self.addBoundaryWithIdentifier(identifier, fromPoint: fromPoint, toPoint: toPoint)
    }
}

