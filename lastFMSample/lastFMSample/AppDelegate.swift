//
//  AppDelegate.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewModel = MainViewModel()
        let rootViewController = ViewController(viewModel: mainViewModel)
        let initialViewController = UINavigationController(rootViewController: rootViewController)
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}

