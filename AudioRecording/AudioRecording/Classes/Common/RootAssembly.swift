//
//  RootAssembly.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class RootAssembly {
    
    lazy var filesAssembly: FilesAssembly = {
        let assembly = FilesAssembly(rootAssembly: self)
        return assembly
    }()
    
    lazy var recordingAssembly: RecordingAssembly = {
        let assembly = RecordingAssembly(rootAssembly: self)
        return assembly
    }()
    
    lazy var loginAssembly: LoginAssembly = {
        let assembly = LoginAssembly(rootAssembly: self)
        return assembly
    }()
    
    lazy var distributionAssembly: DistributionAssembly = {
        let assembly = DistributionAssembly(rootAssembly: self)
        return assembly
    }()
    
    lazy var contactsAssembly: ContactsAssembly = {
        let assembly = ContactsAssembly(rootAssembly: self)
        return assembly
    }()
    
    lazy var sendAssembly: SendAssembly = {
        let assembly = SendAssembly(rootAssembly: self)
        return assembly
    }()
    
    lazy var profileAssembly: ProfileAssembly = {
        let assembly = ProfileAssembly(rootAssembly: self)
        return assembly
    }()
    
}
