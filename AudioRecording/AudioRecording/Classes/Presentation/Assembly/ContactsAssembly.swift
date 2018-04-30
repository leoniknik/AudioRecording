//
//  ContactsAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ContactsAssembly {
    private var rootAssembly: RootAssembly
    
    init(rootAssembly: RootAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    func contactsViewController(contacts: [ContactViewModel] = []) -> ContactsViewController {
        let model = ContactsPresentationModel(contacts: contacts)
        let viewController = ContactsViewController(rootAssembly: rootAssembly, model: model)
        return viewController
    }
}
