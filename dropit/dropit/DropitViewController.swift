//
//  DropitViewController.swift
//  dropit
//
//  Created by Dhinesh Kumar Devanathan on 5/27/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate {

    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop(){
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        lastDropedView = dropView
        dropitBehvior.addDrop(dropView)
    }
    
    @IBOutlet weak var gameView: BezierPathView!
    
    var lastDropedView: UIView?
    
    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(gameView)
        switch sender.state {
        case .Began:
            if let viewToAttachTo = lastDropedView {
                attachment = UIAttachmentBehavior(item: viewToAttachTo, attachedToAnchor: gesturePoint)
                lastDropedView = nil;
            }
        case .Changed:
            attachment?.anchorPoint = gesturePoint
        case .Ended:
            attachment = nil
        default:
            break
        }
    }
    
    var dropsPerRow = 10
    
    var dropSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    let dropitBehvior = DropitBehavior()
    
    var attachment : UIAttachmentBehavior? {
        willSet {
            if attachment != nil {
                animator.removeBehavior(attachment!)
                gameView.setPath(nil, named: PathName.Attachement)
            }
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment!)
                attachment?.action = { [unowned self] in
                    if let attachmentView = self.attachment?.items.first as? UIView {
                        let path = UIBezierPath()
                        path.moveToPoint(self.attachment!.anchorPoint)
                        path.addLineToPoint(attachmentView.center)
                        self.gameView.setPath(path, named: PathName.Attachement)
                    }
                }
            }
        }
    }
    
    lazy var animator : UIDynamicAnimator = {
        let ga = UIDynamicAnimator(referenceView: self.gameView)
        ga.delegate = self
        return ga
    }()
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropitBehvior)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX-barrierSize.width/2, y: gameView.bounds.midY-barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropitBehvior.addBarrier(path, named: PathName.MiddleBarrier)
        gameView.setPath(path, named: PathName.MiddleBarrier)
    }
    
    struct PathName {
        static let MiddleBarrier = "Middle Barrier"
        static let Attachement = "Attachment"
    }
    
    func removeCompletedRow(){
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        repeat{
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            for _ in 0 ..< dropsPerRow {
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), withEvent: nil){
                    if hitView.superview == gameView {
                        dropsFound.append(hitView)
                    } else {
                        rowIsComplete = false;
                    }
                }
                dropFrame.origin.x += dropSize.width
            }
            if rowIsComplete {
                dropsToRemove += dropsFound
            }
            
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        
        for drop in dropsToRemove {
            dropitBehvior.removeDrop(drop)
        }
        
        
    }
    
}


private extension CGFloat {
    static func random(max:Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
        case 0 :return UIColor.greenColor()
            case 1 :return UIColor.blueColor()
            case 2 :return UIColor.orangeColor()
            case 3 :return UIColor.redColor()
            case 4 :return UIColor.purpleColor()
            default :return UIColor.blackColor()
        }
    }
}