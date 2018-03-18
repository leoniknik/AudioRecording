//
//  RecordingAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

final class RecordingAssembly {
    private var rootAssembly: RootAssembly
    
    init(rootAssembly: RootAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    func recordingViewController() -> RecordingViewController? {
        let stb = UIStoryboard(name: "Storyboard", bundle: nil)
        guard let viewController = stb.instantiateInitialViewController() as? RecordingViewController else { return nil }
        let model = RecordingPresentationModel()
        model.delegate = viewController
        viewController.model = model
        viewController.rootAssembly = rootAssembly
        return viewController
    }
}
