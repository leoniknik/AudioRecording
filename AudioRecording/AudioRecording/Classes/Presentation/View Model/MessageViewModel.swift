//
//  MessageViewModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class MessageViewModel {
    var contacts = [ContactViewModel]()
    var record: RecordViewModel?
    
    init(contacts: [ContactViewModel]) {
        self.contacts = contacts
    }
}
