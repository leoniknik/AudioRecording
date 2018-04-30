//
//  SendPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation


final class SendPresentationModel: PresentationModel {
    
    let moneyService = ServiceLayer.shared.moneyService
    
    var message: MessageViewModel
    
    init(message: MessageViewModel) {
        self.message = message
    }
    
    func getCost() {
        state = .loading
        let numbers = message.contacts.map { $0.number }
        //TODO
        guard let duration = message.record?.duration else {
            state = .error(message: "Аудиозапись не выбрана")
            return
        }
        moneyService.getCost(numbers: numbers, duration: 2) { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                self.state = .rich
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
    
}
