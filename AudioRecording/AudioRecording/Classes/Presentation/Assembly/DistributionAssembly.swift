//
//  DistributionAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class DistributionAssembly {
    private var rootAssembly: RootAssembly
    
    init(rootAssembly: RootAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    func distributionViewController() -> DistributionViewController {
        let model = DistributionPresentationModel()
        let viewController = DistributionViewController(rootAssembly: rootAssembly, model: model)
        return viewController
    }
}
