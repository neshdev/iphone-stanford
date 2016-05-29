//
//  AppDelegate.swift
//  Trax
//
//  Created by Dhinesh Kumar Devanathan on 5/29/16.
//  Copyright © 2016 NeshDev Studios. All rights reserved.
//

import UIKit

struct GPXURL {
    static let Notification = "GPXUEL Radio Stattion"
    static let Key = "GPX URL Key" 
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        let center = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: GPXURL.Notification, object: self, userInfo: [GPXURL.Key:url])
        center.postNotification(notification)
        return true
    }
    
}

