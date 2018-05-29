//
//  CallService.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class MessageService: MessageServiceProtocol {
    
    private let requestSender: RequestSenderProtocol
    
    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
    }
    
    func call(filePath: URL, filename: String, title: String, numbers: String, completion: CallCompletion) {
        let request = CallUpload(title: title, numbers: numbers, filePath: filePath, filename: filename)
        requestSender.upload(config: request) { (result) in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
}
