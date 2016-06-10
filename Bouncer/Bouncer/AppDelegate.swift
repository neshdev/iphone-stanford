//
//  AppDelegate.swift
//  Bouncer
//
//  Created by Dhinesh Kumar Devanathan on 5/29/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit
import CoreMotion


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    struct Motion {
        static let Manager = CMMotionManager()
    }

}

