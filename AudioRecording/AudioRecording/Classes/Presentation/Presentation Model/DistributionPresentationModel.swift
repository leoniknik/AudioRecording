//
//  DistributionPresentationModel.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

protocol DistributionPresentationModelDelegate: class {
    func nameDidChanged(at item: Int)
}

final class DistributionPresentationModel: PresentationModel {
    weak var delegate: DistributionPresentationModelDelegate?
    
    var distributions = [DistributionViewModel]()
    
    let distributionService = DistributionProvider()
    
    func obtainDistributions() {
        distributions.removeAll()
        let items = distributionService.readDistributions()
        for item in items {
            distributions.append(DistributionViewModel(title: item.title, contacts: item.contacts.map {
                ContactViewModel(name: $0.name, number: $0.number, isChoosen: true)
            }))
        }
    }
    
    func delete(at item: Int) {
        let distribution = distributions[item]
        distributions.remove(at: item)
        distributionService.deleteDistribution(withTitle: distribution.title)
    }
    
    func change(title: String, at item: Int) {
        let distribution = distributions[item]
        distributionService.renameDistribution(fromTitle: distribution.title, to: title)
        distribution.title = title
        delegate?.nameDidChanged(at: item)
    }
}
