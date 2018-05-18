//
//  CostRequest.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 01.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class CostRequest: RequestConfig<Cost> {
    init(numbers: String, duration: Int) {
        let parameters: Parameters = [
            "Numbers": numbers,
            "Duration": duration
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let parser = CostParser()
        super.init(url: "/Cost", parameters: parameters, headers: headers, method: .post, encoding: JSONEncoding.default, parser: parser)
    }
}
