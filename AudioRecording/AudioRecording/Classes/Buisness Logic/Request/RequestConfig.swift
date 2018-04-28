//
//  RequestConfig.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class RequestConfig<Parser> where Parser: Decodable {
    var baseURL = "http://78.36.152.53/api"
    var url: String
    var parameters: Parameters
    var headers: HTTPHeaders
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var parser: Parser.Type
    
    init(url: String = "",
         parameters: Parameters = [:],
         headers: HTTPHeaders = [:],
         method: HTTPMethod = .get,
         encoding: ParameterEncoding = URLEncoding(destination: .methodDependent),
         parser: Parser.Type) {
        
        self.url = "\(baseURL)\(url)"
        self.parameters = parameters
        self.headers = headers
        self.method = method
        self.encoding = encoding
        self.parser = parser
        
    }
}
