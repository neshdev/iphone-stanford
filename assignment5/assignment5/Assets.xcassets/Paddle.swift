//
//  Paddle.swift
//  assignment5
//
//  Created by Dhinesh Kumar Devanathan on 6/8/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

class Paddle: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = createPaddle()
        let fillColor = UIColor.blueColor()
        fillColor.setFill()
        
        path.lineWidth = 1.0
        let strokeColor = UIColor.blackColor()
        strokeColor.setStroke()
        
        path.fill()
        path.stroke()
    }
    
    private func createPaddle() -> UIBezierPath {
        let height = Double(self.bounds.height)
        let width = Double( self.bounds.width)
        let scalingFactor = 1.0 / 12;
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: width * scalingFactor , y: 0))
        path.addLineToPoint(CGPoint(x: 11 * width * scalingFactor, y: 0))
        path.addArcWithCenter(CGPoint(x: 11 * width * scalingFactor, y: height/2), radius: CGFloat(width * scalingFactor), startAngle: CGFloat(M_PI * 3 / 2), endAngle: CGFloat( M_PI / 2), clockwise: true)
        path.addLineToPoint(CGPoint(x: width * scalingFactor, y: height))
        path.addArcWithCenter(CGPoint(x: width * scalingFactor, y: height/2), radius: CGFloat(width * scalingFactor), startAngle: CGFloat(M_PI / 2), endAngle: CGFloat(M_PI * 3 / 2), clockwise: true)
        path.closePath()
        return path
    }

}
