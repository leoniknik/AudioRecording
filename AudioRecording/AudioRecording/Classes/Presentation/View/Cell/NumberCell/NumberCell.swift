//
//  NumberCell.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class NumberCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupShadow()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        layer.backgroundColor = UIColor.clear.cgColor
        mainView.layer.cornerRadius = 12
        mainView.clipsToBounds = true
    }
    
    private func setupShadow() {
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowRadius = 5
        mainView.layer.masksToBounds = false
    }
    
}
