//
//  Cost.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 01.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class Cost: Decodable {
    var cost: Int
    var errors: [String]
    var result: Bool

    init(cost: Int, errors: [String], result: Bool) {
        self.cost = cost
        self.errors = errors
        self.result = result
    }
    
    enum CodingKeys: String, CodingKey {
        case cost = "Cost"
        case errors = "Errors"
        case result = "Result"
    }
}
