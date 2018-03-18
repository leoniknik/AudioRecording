//
//  ServiceLayer.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ServiceLayer {
    
    static let shared = ServiceLayer()
    
    let audioService: AudioServiceProtocol
    let fileService: FileServiceProtocol
    
    private init() {
        audioService = AudioService()
        fileService = FileService()
    }
    
}
