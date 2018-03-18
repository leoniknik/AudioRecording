//
//  RecordingPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

protocol RecordingPresentationModelDelegate: class {
    func updateMeters(_ normalizeValue: CGFloat)
    func playingFinished()
}

final class RecordingPresentationModel: PresentationModel {
    
    private var audioService = ServiceLayer.shared.audioService
    private var fileService = ServiceLayer.shared.fileService
    
    weak var delegate: RecordingPresentationModelDelegate?
    
    var isPlaying: Bool = false
    var recordUrl: URL?
    
    func setup() {
        recordUrl = fileService.getFileURL()
        audioService.delegate = self
        guard let url = recordUrl else { return }
        audioService.setupRecorder(url: url)
    }
    
    func playOrPause(_ sender: UIButton) {
        if !isPlaying {
            startPlaying()
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            stopPlaying()
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    func startPlaying() {
        guard let url = recordUrl else { return }
        audioService.setupPlayer(url: url)
        audioService.startPlaying()
        isPlaying = true
    }
    
    func stopPlaying() {
        isPlaying = false
        audioService.stopPlaying()
    }
    
    func startRecording() {
        audioService.startRecording()
    }
    
    func stopRecording() {
        audioService.stopRecording()
    }
    
    func deleteRecord() {
        guard let url = recordUrl else { return }
        fileService.delete(url: url)
    }
    
    deinit {
        stopRecording()
        stopPlaying()
        audioService.clear()
    }
}

extension RecordingPresentationModel: AudioServiceDelegate {
    
    func recordingFinished() {
        
    }
    
    func playingFinished() {
        isPlaying = false
        delegate?.playingFinished()
    }
    
    func updateMeters(_ normalizeValue: CGFloat) {
        delegate?.updateMeters(normalizeValue)
    }
}
