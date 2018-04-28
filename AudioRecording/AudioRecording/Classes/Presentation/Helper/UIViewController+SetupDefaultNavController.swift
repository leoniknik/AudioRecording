//
//  UIViewController+SetupDefaultNavController().swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupDefaultNavController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.barStyle = .blackOpaque
        navController.navigationBar.barTintColor = .ccBlue
        return navController
    }
}
