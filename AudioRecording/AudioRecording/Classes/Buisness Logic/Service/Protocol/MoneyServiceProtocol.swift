//
//  MoneyServiceProtocol.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 30.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

protocol MoneyServiceProtocol {
    
    typealias BalanceCompletion = ((Result<Balance>) -> Void)?
    func getBalance(completion: BalanceCompletion)
    
    typealias CostCompletion = ((Result<Cost>) -> Void)?
    func getCost(numbers: [String], duration: Int, completion: CostCompletion)
}
