//
//  AuthUserParser.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class AuthUserParser: Parser<AuthResult> {
    override func parse(_ response: DataResponse<Any>) -> AuthResult? {
        guard let isLogined = response.result.value as? Bool else { return nil }
        let model = AuthResult(isLogined: isLogined)
        return model
    }
}
