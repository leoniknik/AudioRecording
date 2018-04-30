//
//  DistributionViewModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class DistributionViewModel {
    var title: String
    var contacts = [ContactViewModel]()
    
    init(title: String, contacts: [ContactViewModel]) {
        self.title = title
        self.contacts = contacts
    }
}
