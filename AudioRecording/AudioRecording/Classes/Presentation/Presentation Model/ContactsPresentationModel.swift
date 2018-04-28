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
    
    func obtainContacts() {
        state = .loading
        contactsService.obtainContacts { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let contacts):
                self.contacts = contacts.map({
                    ContactViewModel(name: $0.givenName, number: $0.phoneNumbers.first?.value.stringValue ?? "")
                })
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
