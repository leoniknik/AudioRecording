//
//  NumberFormatter.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class NumberFormatter {
    static func filterNumbers(numbers: [String]) -> String {
        var result = "\(numbers)"
        result = result.replacingOccurrences(of: "-", with: "")
        result = result.replacingOccurrences(of: " ", with: "")
        result = result.replacingOccurrences(of: "+", with: "")
        result = result.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: "\\", with: "")
        result = result.replacingOccurrences(of: "\"", with: "")
        return result
    }
}
