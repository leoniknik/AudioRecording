//
//  AuthServiceProtocol.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol {
    
    typealias AuthUserCompletion = ((Result<AuthResult>) -> Void)?
    
    func authUser(login: String, password: String, completion: AuthUserCompletion)
}
