//
//  RootAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class RootAssembly {
    
    lazy var filesAssembly: FilesAssembly = {
        let assembly = FilesAssembly(rootAssembly: self)
        return assembly
    }()
    
}
