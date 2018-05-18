//
//  String+FileExtension.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 05.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

extension String {
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}
