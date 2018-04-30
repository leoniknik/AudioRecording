//
//  Constant.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class Constants {
    static var recordsPath: URL? {
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath =  tDocumentDirectory.appendingPathComponent("records")
            return filePath
        } else {
            return nil
        }
    }
}
