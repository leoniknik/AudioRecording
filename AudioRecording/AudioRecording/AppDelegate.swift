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

        openInitialViewController()
        return true
    }
    
    private func openInitialViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navController = setupNavigationViewController()
        let viewController = rootAssembly.filesAssembly.filesViewController()
        navController.viewControllers.append(viewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationViewController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.barStyle = .blackOpaque
        navController.navigationBar.barTintColor = .ccRed
        return navController
    }
    
}



