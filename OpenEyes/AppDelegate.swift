//
//  AppDelegate.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 11/03/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }



}

