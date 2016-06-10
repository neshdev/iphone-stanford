//
//  Ball.swift
//  assignment5
//
//  Created by Dhinesh Kumar Devanathan on 6/6/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class Ball: UIView {
    override func drawRect(rect: CGRect) {
        let circlePath = createCirclePath()
        let fillColor = UIColor.orangeColor()
        fillColor.setFill()
        
        circlePath.lineWidth = 1.0
        let strokeColor = UIColor.blackColor()
        strokeColor.setStroke()
        
        circlePath.fill()
        circlePath.stroke()
    }
    
    private var ballCenter : CGPoint {
        return self.convertPoint(self.center, fromView: superview)
    }
    
    func createCirclePath() -> UIBezierPath {
        let radius = self.bounds.size.height / 2
        let path = UIBezierPath(arcCenter: ballCenter, radius: radius, startAngle: 0, endAngle: CGFloat( 2 * M_PI), clockwise: true)
        return path
    }
    
    private struct Constants {
        
    }

}
