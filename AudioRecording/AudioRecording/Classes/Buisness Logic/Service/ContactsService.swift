//
//  ContactsService.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Contacts

final class ContactsService: ContactsServiceProtocol {
    
    func obtainContacts(completion: ContactsCompletion) {
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey
            ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                contacts.append(contact)
            }
            completion?(Result.success(contacts))
        } catch {
            print("unable to fetch contacts")
            completion?(Result.error("Не удалось получить доступ к контактам"))
        }
    }
    
}
