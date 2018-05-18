//
//  MoneyService.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 30.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class MoneyService: MoneyServiceProtocol {
    
    private let requestSender: RequestSenderProtocol
    
    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
    }
    
    func getBalance(completion: BalanceCompletion) {
        let request = BalanceRequest()
        requestSender.request(config: request) { (result) in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    
    func getCost(numbers: [String], duration: Int, completion: CostCompletion) {
        let numbersParam = filterNumbers(numbers: numbers)
        let request = CostRequest(numbers: numbersParam, duration: duration)
        requestSender.request(config: request) { (result) in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    
    private func filterNumbers(numbers: [String]) -> String {
        var result = "\(numbers)"
        result = result.replacingOccurrences(of: "-", with: "")
        result = result.replacingOccurrences(of: " ", with: "")
        result = result.replacingOccurrences(of: "+", with: "")
        result = result.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: "\\", with: "")
        result = result.replacingOccurrences(of: "\"", with: "")
        return result
    }
    
}
