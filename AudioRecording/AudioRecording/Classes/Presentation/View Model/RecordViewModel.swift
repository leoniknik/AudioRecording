//
//  RecordViewModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class RecordViewModel {
    var recordTitle: String
    var duration: String
    
    init(recordTitle: String, duration: String) {
        self.recordTitle = recordTitle
        self.duration = duration
    }
}
