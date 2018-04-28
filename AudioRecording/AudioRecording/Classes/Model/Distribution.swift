//
//  Distribution.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class Distribution {
    var title: String
    var contacts: [Contact]
    
    init(title: String, contacts: [Contact]) {
        self.title = title
        self.contacts = contacts
    }
}
