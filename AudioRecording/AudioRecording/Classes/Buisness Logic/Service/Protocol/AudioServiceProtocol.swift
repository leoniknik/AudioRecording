//
//  AudioServiceProtocol.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

protocol AudioServiceProtocol {
    weak var delegate: AudioServiceDelegate? { get set }
    
    func setupRecorder(url: URL)
    func setupPlayer(url: URL)
    
    func stopRecording()
    func startRecording()
    
    func startPlaying()
    func stopPlaying()
    
    func clear()
}
