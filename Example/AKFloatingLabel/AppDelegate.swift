//
//  AppDelegate.swift
//  AKFloatingLabel
//
//  Created by Diogo Autilio on 07/03/2017.
//  Copyright (c) 2017 Diogo Autilio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        window?.backgroundColor = UIColor.white

        let navigationController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
