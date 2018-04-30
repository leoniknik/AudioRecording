//
//  ProfileAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 30.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ProfileAssembly {
    private var rootAssembly: RootAssembly
    
    init(rootAssembly: RootAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    func profileViewController() -> ProfileViewController {
        let model = ProfilePresentationModel()
        let viewController = ProfileViewController(rootAssembly: rootAssembly, model: model)
        return viewController
    }
}
