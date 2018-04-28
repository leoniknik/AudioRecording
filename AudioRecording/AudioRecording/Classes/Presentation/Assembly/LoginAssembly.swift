//
//  LoginAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class LoginAssembly {
    private var rootAssembly: RootAssembly
    
    init(rootAssembly: RootAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    func loginViewController() -> LoginViewController {
        let model = LoginPresentationModel()
        let viewController = LoginViewController(rootAssembly: rootAssembly, model: model)
        return viewController
    }
}
