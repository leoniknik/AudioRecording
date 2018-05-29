//
//  MessageServiceProtocol.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

protocol MessageServiceProtocol {
    
//    typealias BalanceCompletion = ((Result<Balance>) -> Void)?
//    func getBalance(completion: BalanceCompletion)
    
    typealias CallCompletion = ((Result<CallResult>) -> Void)?
    func call(filePath: URL, filename: String, title: String, numbers: String, completion: CallCompletion)
}
