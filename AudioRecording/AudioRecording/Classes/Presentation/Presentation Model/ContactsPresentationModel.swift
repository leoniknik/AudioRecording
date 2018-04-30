//
//  ContactsPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ContactsPresentationModel: PresentationModel {
    
    var contacts = [ContactViewModel]()
    
    var choosenContacts: [ContactViewModel] {
        return contacts.filter { $0.isChoosen }
    }
    
    let contactsService = ServiceLayer.shared.contactsService
    let distributionProvider = DistributionProvider()
    
    init(contacts: [ContactViewModel] = []) {
        for contact in contacts {
            self.contacts.append(ContactViewModel(name: contact.name, number: contact.number, isChoosen: true))
        }
    }
    
    func obtainContacts() {
        state = .loading
        contactsService.obtainContacts { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let newContacts):
                let numberArray = self.contacts.map { $0.number }
                for newContact in newContacts {
                    if numberArray.contains(newContact.number) {
                        continue
                    } else {
                        self.contacts.append(ContactViewModel(name: newContact.name, number: newContact.number))
                    }
                }
                self.state = .rich
            case .error(let error):
                self.state = .error(message: error)
            }
        }
    }
    
    func addCustomNumber(number: String) {
        let contact = ContactViewModel(name: "Добавленный номер", number: number)
        contact.isChoosen = true
        contacts.append(contact)
        state = .rich
    }
    
    func saveDistribution(title: String) -> Bool {
        if distributionProvider.checkDistribution(byName: title) {
            return false
        }
        let contacts = choosenContacts.map {
            Contact(name: $0.name, number: $0.number)
        }
        return distributionProvider.saveDistribution(title: title, contacts: contacts)
    }
    
}
