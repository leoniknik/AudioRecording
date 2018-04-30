//
//  BalanceParser.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 30.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class BalanceParser: Parser<Balance> {
    override func parse(_ response: DataResponse<Any>) -> Balance? {
        guard let amount = response.result.value as? Double else { return nil }
        let model = Balance(amount: amount)
        return model
    }
}
