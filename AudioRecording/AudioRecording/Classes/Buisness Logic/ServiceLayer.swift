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
    let requestService: RequestSenderProtocol
    let authService: AuthServiceProtocol
    let contactsService: ContactsServiceProtocol
    
    private init() {
        requestService = RequestSender()
        
        authService = AuthService(requestSender: requestService)
        
        audioService = AudioService()
        fileService = FileService()
        contactsService = ContactsService()
        
    }
    
}
