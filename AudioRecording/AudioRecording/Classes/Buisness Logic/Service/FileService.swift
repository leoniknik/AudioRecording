//
//  FileService.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class FileService: FileServiceProtocol {
    
    func getFileURL() -> URL? {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let filePath = documentsURL.appendingPathComponent(recordTitle)
        return filePath
    }
    
    var recordTitle: String {
        let defaults = UserDefaults()
        var number = defaults.integer(forKey: "number")
        let recordTitle = "Запись \(number)"
        number += 1
        defaults.set(number, forKey: "number")
        return recordTitle
    }
    
}

