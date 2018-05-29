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
    init(title: String, numbers: String, filePath: URL, filename: String) {
        let file = FileUpload(filePath: filePath, fileName: filename, parameterName: "Content", mimeType: "audio/wav")
        let parameters: Parameters = [
//            "Title": title,
            "Title": "Запись",
            "Numbers": "[3333]"
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "multipart/form-data"
        ]
        let parser = CallParser()
        super.init(url: "/Call", parameters: parameters, headers: headers, method: .post, encoding: JSONEncoding.default, parser: parser, file: file)
    }
}
