//
//  CallResult.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class CallResult: Decodable {
    var result: Bool
    var errors: [String]
    var callID: Int
    
    init(result: Bool, errors: [String], callID: Int) {
        self.result = result
        self.errors = errors
        self.callID = callID
    }
    
    enum CodingKeys: String, CodingKey {
        case callID = "CallId"
        case errors = "Errors"
        case result = "Result"
    }
}
