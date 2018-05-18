//
//  ProfilePresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 30.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class ProfilePresentationModel {
    
    enum ProfileState {
        case loading
        case richBalance
        case richLogout
        case error(message: String)
    }
    
    typealias ChangeStateHandler = (ProfileState) -> Void
    var changeStateHandler: ChangeStateHandler?
    
    var state: ProfileState = .richBalance {
        didSet {
            changeStateHandler?(state)
        }
    }
    
    let moneyService = ServiceLayer.shared.moneyService
    let authService = ServiceLayer.shared.authService
    
    var balance = 0.0
    var canLogout = false
    
    func getBalance() {
        state = .loading
        moneyService.getBalance() { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                self.balance = result.amount
                self.state = .richBalance
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
    
    func logout() {
        state = .loading
        authService.logout() { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                self.canLogout = result.canLogout
                self.state = .richLogout
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
}
