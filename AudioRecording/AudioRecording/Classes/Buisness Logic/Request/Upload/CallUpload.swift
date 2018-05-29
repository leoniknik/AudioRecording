//
//  CallUpload.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class CallUpload: UploadConfig<CallResult> {
    init(title: String, numbers: String, duration: Int, file: FileUpload) {
        
        let parameters: Parameters = [
            "Title": title,
            "Numbers": numbers,
            "Duration": duration
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "multipart/form-data"
        ]
        let parser = CallParser()
        super.init(url: "/Call", parameters: parameters, headers: headers, method: .post, encoding: JSONEncoding.default, parser: parser, file: file)
    }
}
