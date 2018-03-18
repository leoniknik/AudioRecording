//
//  AudioService.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import AVFoundation

@objc protocol AudioServiceDelegate: class {
    @objc optional func updateMeters(_ normalizeValue: CGFloat)
    @objc optional func recordingFinished()
    @objc optional func playingFinished()
}

final class AudioService: NSObject, AudioServiceProtocol {

    weak var delegate: AudioServiceDelegate?
    
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    var displayLink: CADisplayLink?
    
    func setupRecorder(url: URL) {
        let settings: [String : Any] = [
            AVSampleRateKey: 44100.0,
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: url, settings: settings)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            return
        }
        
        guard let recorder = recorder else { return }
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.delegate = self
        recorder.record()
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateMeters))
        displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    @objc func updateMeters() {
        guard let recorder = recorder else { return }
        recorder.updateMeters()
        let normalizedValue: CGFloat = pow(10, CGFloat(recorder.averagePower(forChannel: 0))/20) + 0.05
        delegate?.updateMeters?(normalizedValue)
    }
    
    func setupPlayer(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            return
        }
        
        player?.delegate = self
        player?.prepareToPlay()
        player?.volume = 1.0
    }
    
    func stopRecording() {
        recorder?.stop()
    }
    
    func startRecording() {
        recorder?.prepareToRecord()
        recorder?.record()
    }
    
    func startPlaying() {
        player?.play()
    }
    
    func stopPlaying() {
        player?.stop()
    }
    
    func clear() {
        displayLink?.remove(from: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
}

extension AudioService: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        delegate?.recordingFinished?()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.playingFinished?()
    }
}
