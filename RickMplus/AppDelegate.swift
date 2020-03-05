//
//  AppDelegate.swift
//  RickM+
//
//  Created by RickSun on 2020/1/30.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Firebase
//import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
//        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

}

