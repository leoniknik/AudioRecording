//
//  PresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class PresentationModel {
    
    enum State {
        case loading
        case rich
        case error(message: String)
    }
    
    typealias ChangeStateHandler = (State) -> Void
    var changeStateHandler: ChangeStateHandler?
    
    var state: State = .rich {
        didSet {
            changeStateHandler?(state)
        }
    }
    
}
