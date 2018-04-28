//
//  SendAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class SendAssembly {
    private var rootAssembly: RootAssembly
    
    init(rootAssembly: RootAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    func sendViewController(message: MessageViewModel) -> SendViewController {
        let model = SendPresentationModel(message: message)
        let viewController = SendViewController(rootAssembly: rootAssembly, model: model)
        return viewController
    }
}
