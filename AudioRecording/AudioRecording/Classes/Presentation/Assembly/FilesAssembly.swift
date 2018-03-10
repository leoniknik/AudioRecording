//
//  FilesAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class FilesAssembly {
    private var rootAssembly: RootAssembly
    
    init(rootAssembly: RootAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    func filesViewController() -> FilesViewController {
        let model = FilesPresentationModel()
        let viewController = FilesViewController(rootAssembly: rootAssembly, model: model)
        return viewController
    }
}
