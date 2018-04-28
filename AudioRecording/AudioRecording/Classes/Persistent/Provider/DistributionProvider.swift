//
//  DistributionProvider.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import RealmSwift

class DistributionProvider {
    
    var realm: Realm? {
        do {
            return try Realm()
        } catch(let error) {
            print(error)
            return nil
        }
    }
    
    func saveDistribution(title: String, contacts: [Contact]) -> Bool {
        guard let realm = self.realm else { return false }
        do {
            let rmDistribution = RMDistribution()
            rmDistribution.title = title
            for contact in contacts {
                let rmContact = RMContact()
                rmContact.name = contact.name
                rmContact.number = contact.number
                rmContact.distribution = rmDistribution
            }
            try realm.write {
                realm.add(rmDistribution)
            }
            return true
        } catch {
            return false
        }
    }
    
    func readDistributions() -> [Distribution] {
        guard let realm = realm else { return [] }
        let distributions = realm.objects(RMDistribution.self)
        var result = [Distribution]()
        for item in distributions {
            result.append(Distribution(title: item.title, contacts: item.contacts.map {
                Contact(name: $0.name, number: $0.number)
            }))
        }
        return result
    }
    
    func checkDistribution(byName name: String) -> Bool {
        let distributions = readDistributions()
        for distribution in distributions {
            if distribution.title == name {
                return true
            }
        }
        return false
    }
    
}
