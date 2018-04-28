//
//  AuthUserRequest.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class AuthUserRequest: RequestConfig<AuthResult> {
    init(login: String, password: String) {
        let parameters: Parameters = [
            "Login": login,
            "Password": password
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let parser = AuthUserParser()
        super.init(url: "/Login", parameters: parameters, headers: headers, method: .post, encoding: JSONEncoding.default, parser: parser)
    }
}
