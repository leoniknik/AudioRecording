//
//  String+Time.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

extension TimeInterval {
    func timeString() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

