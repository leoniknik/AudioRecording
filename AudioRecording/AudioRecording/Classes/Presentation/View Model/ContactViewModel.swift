//
//  ContactViewModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ContactViewModel {
    var name: String
    var number: String
    var isChoosen: Bool
    
    init(name: String, number: String, isChoosen: Bool = false) {
        self.name = name
        self.number = number
        self.isChoosen = isChoosen
    }
}
