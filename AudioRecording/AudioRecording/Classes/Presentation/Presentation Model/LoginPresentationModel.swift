//
//  LoginPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class LoginPresentationModel: PresentationModel {
    
    let authService = ServiceLayer.shared.authService
    var isLogined = false
    
    func authUser(byLogin login: String, password: String) {
        state = .loading
        authService.authUser(login: login, password: password) { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                self.isLogined = result.isLogined
                self.state = .rich
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
}
