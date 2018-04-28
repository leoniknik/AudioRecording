//
//  DistributionFooterView.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

protocol DistributionFooterViewDelegate: class {
    func addTapped()
}

class DistributionFooterView: UITableViewHeaderFooterView {

    weak var delegate: DistributionFooterViewDelegate?
    
    @IBAction func addTapped(_ sender: UIButton) {
        delegate?.addTapped()
    }
    
}
