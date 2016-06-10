//
//  DropitBehavior.swift
//  dropit
//
//  Created by Dhinesh Kumar Devanathan on 5/27/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class DropitBehavior: UIDynamicBehavior {

    let gravity = UIGravityBehavior()
    
    lazy var collider : UICollisionBehavior = {
        let cc = UICollisionBehavior()
        cc.translatesReferenceBoundsIntoBoundary = true
        return cc
    }()
    
    lazy var dropBehavior : UIDynamicItemBehavior = {
       let cdb = UIDynamicItemBehavior()
        cdb.allowsRotation = false
        cdb.elasticity = 0.75
        return cdb
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
    }
    
    func addDrop(drop: UIView){
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    
    func removeDrop(drop: UIView){
        dropBehavior.removeItem(drop)
        gravity.removeItem(drop)
        collider.removeItem(drop)
        drop.removeFromSuperview()
    }
    
    
    func addBarrier(path: UIBezierPath, named name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    
}
