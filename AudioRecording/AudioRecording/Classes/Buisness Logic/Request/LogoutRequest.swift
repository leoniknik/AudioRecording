//
//  LogoutRequest.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 01.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class LogoutRequest: RequestConfig<LogoutResult> {
    init() {
        let parameters: Parameters = [:]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let parser = LogoutParser()
        super.init(url: "/Logout", parameters: parameters, headers: headers, method: .post, encoding: JSONEncoding.default, parser: parser)
    }
}
