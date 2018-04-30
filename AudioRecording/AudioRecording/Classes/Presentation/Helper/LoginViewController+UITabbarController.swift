//
//  LoginViewController+UITabbarController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

extension LoginViewController {
    func setupTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        //distribution screen
        let distributionNC = setupDefaultNavController()
        let distributionVC = rootAssembly.distributionAssembly.distributionViewController()
        distributionNC.viewControllers.append(distributionVC)
        tabBarController.viewControllers = [distributionNC]
        
        //recording screen
        let recordingNC = setupDefaultNavController()
        let recordingVC = rootAssembly.filesAssembly.filesViewController()
        recordingNC.viewControllers.append(recordingVC)
        tabBarController.viewControllers?.append(recordingNC)
        
        //status screen
        let statusNC = setupDefaultNavController()
        let statusVC = UIViewController()
        statusNC.viewControllers.append(statusVC)
        tabBarController.viewControllers?.append(statusNC)
        
        //profile screen
        let profileNC = setupDefaultNavController()
        let profileVC = rootAssembly.profileAssembly.profileViewController()
        profileNC.viewControllers.append(profileVC)
        tabBarController.viewControllers?.append(profileNC)
        
        guard let item1 = tabBarController.tabBar.items?[1] else { return tabBarController }
        item1.image = UIImage(named: "blue-micro")?.withRenderingMode(.alwaysOriginal)
        item1.selectedImage = UIImage(named: "white-micro-2")?.withRenderingMode(.alwaysOriginal)
        item1.title = "Аудиозаписи"
        
        guard let item2 = tabBarController.tabBar.items?[0] else { return tabBarController }
        item2.image = UIImage(named: "blue-message")?.withRenderingMode(.alwaysOriginal)
        item2.selectedImage = UIImage(named: "white-message")?.withRenderingMode(.alwaysOriginal)
        item2.title = "Рассылки"
        
        guard let item3 = tabBarController.tabBar.items?[2] else { return tabBarController }
        item3.image = UIImage(named: "blue-bell")?.withRenderingMode(.alwaysOriginal)
        item3.selectedImage = UIImage(named: "white-bell")?.withRenderingMode(.alwaysOriginal)
        item3.title = "Статусы"
        
        guard let item4 = tabBarController.tabBar.items?[3] else { return tabBarController }
        item4.image = UIImage(named: "blue-human")?.withRenderingMode(.alwaysOriginal)
        item4.selectedImage = UIImage(named: "white-human")?.withRenderingMode(.alwaysOriginal)
        item4.title = "Профиль"
        
        return tabBarController
    }
    
}
