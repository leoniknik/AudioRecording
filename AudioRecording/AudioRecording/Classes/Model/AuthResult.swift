//
//  AuthResult.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class AuthResult: Decodable {
    var isLogined: Bool = false
    
    init(isLogined: Bool) {
        self.isLogined = isLogined
    }
    
    enum CodingKeys: String, CodingKey {
        case isLogined = ""
    }
}
