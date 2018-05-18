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
    var cost: Cost?
    
    init(message: MessageViewModel) {
        self.message = message
    }
    
    var numbers: [String] {
        return message.contacts.map { $0.number }
    }
    
    func getCost() {
        state = .loading
        //TODO
        guard let duration = message.record?.duration else {
            state = .error(message: "Аудиозапись не выбрана")
            return
        }
        moneyService.getCost(numbers: numbers, duration: 5) { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                self.cost = result
                self.state = .rich
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
    
    func send() {
        state = .loading
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var balance = Balance(amount: 0.0)
        moneyService.getBalance { (data) in
            switch data {
            case .success(let result):
                balance = result
            case .error(let description):
                print(description)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        var cost = Cost(cost: 0, errors: [], result: false)
        moneyService.getCost(numbers: numbers, duration: 5) { (data) in
            switch data {
            case .success(let result):
                cost = result
            case .error(let description):
                print(description)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if cost.cost > Int(balance.amount) {
                self.state = .error(message: "Недостаточно средств на счету")
            } else {
                self.sendCall()
            }
        }
    }
    
    private func sendCall() {
        self.state = .rich
    }
    
}
