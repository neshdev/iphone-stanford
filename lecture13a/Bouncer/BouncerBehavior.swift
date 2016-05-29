//
//  BouncerBehavior.swift
//  Bouncer
//
//  Created by Dhinesh Kumar Devanathan on 5/29/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class BouncerBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    
    lazy var collider : UICollisionBehavior = {
        let cc = UICollisionBehavior()
        cc.translatesReferenceBoundsIntoBoundary = true
        return cc
    }()
    
    lazy var blockBehavior : UIDynamicItemBehavior = {
        let cdb = UIDynamicItemBehavior()
        cdb.allowsRotation = false
        cdb.elasticity = 0.85
        cdb.friction = 0
        cdb.resistance = 0
        return cdb
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(blockBehavior)
    }
    
    func addblock(block: UIView){
        dynamicAnimator?.referenceView?.addSubview(block)
        gravity.addItem(block)
        collider.addItem(block)
        blockBehavior.addItem(block)
    }
    
    func removeblock(block: UIView){
        blockBehavior.removeItem(block)
        gravity.removeItem(block)
        collider.removeItem(block)
        block.removeFromSuperview()
    }
    
    
    func addBarrier(path: UIBezierPath, named name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }

}
