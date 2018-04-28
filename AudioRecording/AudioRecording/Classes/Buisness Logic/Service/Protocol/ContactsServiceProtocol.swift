//
//  ContactsServiceProtocol.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Contacts

protocol ContactsServiceProtocol {
    
    typealias ContactsCompletion = ((Result<[CNContact]>) -> Void)?
    
    func obtainContacts(completion: ContactsCompletion)
}
