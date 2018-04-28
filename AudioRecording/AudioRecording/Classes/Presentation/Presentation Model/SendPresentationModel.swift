//
//  SendPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class SendPresentationModel: PresentationModel {
    
    var message: MessageViewModel
    
    init(message: MessageViewModel) {
        self.message = message
    }
    
}
