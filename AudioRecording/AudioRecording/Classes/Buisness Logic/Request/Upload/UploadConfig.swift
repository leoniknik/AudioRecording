//
//  UploadConfig.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class UploadConfig<Model>: RequestConfig<Model> {
    
    var file: FileUpload
    
    init(url: String = "",
         parameters: Parameters = [:],
         headers: HTTPHeaders = [:],
         method: HTTPMethod = .get,
         encoding: ParameterEncoding = URLEncoding(destination: .methodDependent),
         parser: Parser<Model>,
         file: FileUpload) {
        
        self.file = file
        super.init(url: url, parameters: parameters, headers: headers, method: method, encoding: encoding, parser: parser)
        
    }
}

final class FileUpload {
    var filePath: URL
    var fileName: String
    var parameterName: String
    var mimeType: String
    
    init(filePath: URL, fileName: String, parameterName: String, mimeType: String) {
        self.filePath = filePath
        self.fileName = fileName
        self.parameterName = parameterName
        self.mimeType = mimeType
    }
}
