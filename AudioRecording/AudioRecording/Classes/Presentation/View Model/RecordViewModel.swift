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
    var duration: Double
    
    init(recordTitle: String, duration: Double) {
        self.recordTitle = recordTitle
        self.duration = duration
    }
}
