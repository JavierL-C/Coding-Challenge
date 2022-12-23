//
//  AppDelegate.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let app = App()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = app.navigationController
        window?.makeKeyAndVisible()
        app.start()
        return true
    }
}

