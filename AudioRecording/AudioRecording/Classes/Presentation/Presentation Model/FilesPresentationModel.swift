//
//  FilesPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class FilesPresentationModel: PresentationModel {
    var audioRecords = [RecordViewModel]()
    
    func obtainAudioRecords() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            audioRecords = fileURLs.map {
                RecordViewModel(recordTitle: $0.lastPathComponent, duration: 0.0)
            }
        } catch {
            print(error)
        }
    }

}
