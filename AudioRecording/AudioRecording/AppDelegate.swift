//
//  AppDelegate.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let rootAssembly = RootAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupTabBar()
        openInitialViewController()
        return true
    }
    
    private func openInitialViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UIViewController().setupDefaultNavController()
        let viewController = rootAssembly.loginAssembly.loginViewController()
        navController.viewControllers = [viewController]
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    private func setupTabBar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.ccBlue], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.ccBlue], for: .normal)
    }
}



