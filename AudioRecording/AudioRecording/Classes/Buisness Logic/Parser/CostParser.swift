//
//  CostParser.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 01.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class CostParser: Parser<Cost> {
    override func parse(_ response: DataResponse<Any>) -> Cost? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(Cost.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
