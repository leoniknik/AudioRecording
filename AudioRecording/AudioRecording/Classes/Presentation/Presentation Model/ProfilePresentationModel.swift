//
//  ProfilePresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 30.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class ProfilePresentationModel: PresentationModel {
    
    let moneyService = ServiceLayer.shared.moneyService
    var balance = 0.0
    
    func getBalance() {
        state = .loading
        moneyService.getBalance() { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                self.balance = result.amount
                self.state = .rich
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
}
