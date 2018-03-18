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
            play()
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            stop()
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    deinit {
        stop()
        audioService.clear()
    }
    
    func play() {
        guard let url = recordUrl else { return }
        audioService.setupPlayer(url: url)
        audioService.startPlaying()
        isPlaying = true
    }
    
    func stop() {
        isPlaying = false
        audioService.stopRecording()
    }
}

extension RecordingPresentationModel: AudioServiceDelegate {
    func updateMeters(_ normalizeValue: CGFloat) {
        delegate?.updateMeters(normalizeValue)
    }
}
