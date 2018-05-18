//
//  LogoutParser.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 01.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class LogoutParser: Parser<LogoutResult> {
    override func parse(_ response: DataResponse<Any>) -> LogoutResult? {
        guard let canLogout = response.result.value as? Bool else { return nil }
        let model = LogoutResult(canLogout: canLogout)
        return model
    }
}
