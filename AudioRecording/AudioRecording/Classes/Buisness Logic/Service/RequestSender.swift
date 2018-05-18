//
//  RequestSender.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case error(String)
}

final class RequestSender: RequestSenderProtocol {
    
    var sessionManager: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request<Model>(config: RequestConfig<Model>, completionHandler: CompletionHandler<Model>) {
        let utilityQueue = DispatchQueue.global(qos: .utility)
        sessionManager.request(config.url,
                        method: config.method,
                        parameters: config.parameters,
                        encoding: config.encoding,
                        headers: config.headers)
            .validate()
            .responseJSON(queue: utilityQueue) { response in
                switch response.result {
                case .success:
                    guard let result = config.parser.parse(response) else {
                        completionHandler?(Result.error("Ошибка при получении данных"))
                        return
                    }
                    completionHandler?(Result.success(result))
                case .failure(let error):
                    debugPrint(error)
                    completionHandler?(Result.error("Нет связи с сервером"))
                }
        }
    }
    
    
    func upload() {
        guard let filePath = Constants.recordsPath?.appendingPathComponent("Запись 1.wav") else { return }

        let parameters = [
            "Title": "Запись 0",
            "Numbers": "[1111]"
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "multipart/form-data"
        ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
            multipartFormData.append(filePath, withName: "Content", fileName: "Запись 1.wav", mimeType: "audio/wav")
        }, to: "http://78.36.152.53/api/Call", method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}

