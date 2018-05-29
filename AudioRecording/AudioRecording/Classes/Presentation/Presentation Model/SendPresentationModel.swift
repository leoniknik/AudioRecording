//
//  SendPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class SendPresentationModel {
    
    enum SendState {
        case loading
        case richCost
        case richCall
        case error(message: String)
    }
    
    typealias ChangeStateHandler = (SendState) -> Void
    var changeStateHandler: ChangeStateHandler?
    
    var state: SendState = .richCost {
        didSet {
            changeStateHandler?(state)
        }
    }
    
    let moneyService = ServiceLayer.shared.moneyService
    let messageService = ServiceLayer.shared.messageService
    
    var message: MessageViewModel
    //TODO ViewModel
    var cost: Cost?
    
    init(message: MessageViewModel) {
        self.message = message
    }
    
    var numbers: [String] {
        return message.contacts.map { $0.number }
    }
    
    func getCost() {
        guard let _ = message.record?.duration else { return }
        state = .loading
        //TODO
        moneyService.getCost(numbers: numbers, duration: 5) { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                self.cost = result
                self.state = .richCost
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
    
    func send() {
        guard let _ = message.record else {
            state = .error(message: "Аудиозапись не выбрана")
            return
        }
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
        //TODO исправить duration
        moneyService.getCost(numbers: numbers, duration: 4) { (data) in
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
        guard let record = message.record else { return }
        guard let filePath = Constants.recordsPath?.appendingPathComponent(record.name) else { return }
        let numbersAsString = NumberFormatter.filterNumbers(numbers: numbers)
        state = .loading
        
        messageService.call(filePath: filePath, filename: record.recordTitle, title: record.name, numbers: numbersAsString) { [weak self] (data) in
            guard let `self` = self else { return }
            switch data {
            case .success(let result):
                print(result)
                self.state = .richCall
            case .error(let description):
                self.state = .error(message: description)
            }
        }
    }
    
}
