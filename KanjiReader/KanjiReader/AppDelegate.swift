//
//  AppDelegate.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ViewController")
        let navVC = UINavigationController.init(rootViewController: mainVC)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }
}

