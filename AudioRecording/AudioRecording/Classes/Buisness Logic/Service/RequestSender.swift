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
    
    
    func upload<Model>(config: UploadConfig<Model>, completionHandler: CompletionHandler<Model>) {
        
        guard let parameters = config.parameters as? [String: String] else {
            completionHandler?(Result.error("Не верные параметры"))
            return
        }

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
            multipartFormData.append(config.file.filePath, withName: config.file.parameterName, fileName: config.file.fileName, mimeType: config.file.mimeType)
        }, to: config.url, method: config.method, headers: config.headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    guard let result = config.parser.parse(response) else {
                        completionHandler?(Result.error("Ошибка при получении данных"))
                        return
                    }
                    completionHandler?(Result.success(result))
                }
            case .failure(let encodingError):
                debugPrint(encodingError)
                completionHandler?(Result.error("Нет удалось загрузить файл"))
            }
        }
    }
}

