//
//  FilesPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import AVFoundation

protocol FilesPresentationModelDelegate: class {
    func playingFinished()
}

final class FilesPresentationModel: PresentationModel {
    var audioRecords = [RecordViewModel]()
    
    private var audioService = ServiceLayer.shared.audioService
    private var fileService = ServiceLayer.shared.fileService
    
    weak var delegate: FilesPresentationModelDelegate?
    
    func obtainAudioRecords() {
        state = .loading
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            audioRecords = fileURLs.map {
                var player: AVAudioPlayer?
                do {
                    player = try AVAudioPlayer(contentsOf: $0)
                } catch {
                    print(error)
                }
                return RecordViewModel(recordTitle: $0.lastPathComponent, duration:
                    player?.duration.timeString() ?? "00:00")
            }
            state = .rich
        } catch {
            print(error)
            state = .error(message: "Не удалось загрузить файлы")
        }
    }
    
    func playRecord(item: Int) {
        guard let url = fileService.find(byName: audioRecords[item].recordTitle) else { return }
        audioService.setupPlayer(url: url)
        audioService.startPlaying()
        audioService.delegate = self
    }
    
    func stopRecord(item: Int) {
        audioService.stopPlaying()
    }
    
    func deleteRecord(item: Int) {
        guard let url = fileService.find(byName: audioRecords[item].recordTitle) else { return }
        fileService.delete(url: url)
        audioRecords.remove(at: item)
    }

}

extension FilesPresentationModel: AudioServiceDelegate {
    
    func playingFinished() {
        delegate?.playingFinished()
    }
    
}
