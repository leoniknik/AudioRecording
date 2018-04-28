//
//  AuthService.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class AuthService: AuthServiceProtocol {
    
    private let requestSender: RequestSenderProtocol
    
    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
    }
    
    func authUser(login: String, password: String, completion: AuthUserCompletion) {
        let request = AuthUserRequest(login: login, password: password)
        requestSender.request(config: request) { (result) in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    
}
