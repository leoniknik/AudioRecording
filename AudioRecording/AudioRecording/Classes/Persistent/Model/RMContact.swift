//
//  RMContact.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import RealmSwift

class RMContact: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var number: String = ""
    @objc dynamic var distribution: RMDistribution?
}
