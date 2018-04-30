//
//  BalanceRequest.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 30.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class BalanceRequest: RequestConfig<Balance> {
    init() {
        let parameters: Parameters = [:]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let parser = BalanceParser()
        super.init(url: "/Money", parameters: parameters, headers: headers, method: .post, encoding: JSONEncoding.default, parser: parser)
    }
}
