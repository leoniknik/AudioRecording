//
//  CallParser.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class CallParser: Parser<CallResult> {
    override func parse(_ response: DataResponse<Any>) -> CallResult? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(CallResult.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
