//
//  RequestSenderProtocol.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

protocol RequestSenderProtocol: class {
    
    typealias CompletionHandler<Model> = ((Result<Model>) -> Void)?
    
    func request<Model>(config: RequestConfig<Model>, completionHandler: CompletionHandler<Model>)
    func upload<Model>(config: UploadConfig<Model>, completionHandler: CompletionHandler<Model>)
}
