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
        return find(byName: recordTitle)
    }
    
    func find(byName name: String) -> URL? {
        guard let dir = Constants.recordsPath else { return nil }
        
        let filePath = dir.appendingPathComponent(name)
        return filePath
    }
    
    func delete(url: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: url)
        }
        catch let error {
            print(error)
        }
    }
    
    private var recordTitle: String {
        let defaults = UserDefaults()
        var number = defaults.integer(forKey: "number")
        let recordTitle = "Запись \(number)"
        number += 1
        defaults.set(number, forKey: "number")
        return recordTitle
    }
    
}

