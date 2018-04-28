//
//  ContactCell.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var chooseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        chooseView.backgroundColor = UIColor.white
        chooseView.layer.borderColor = UIColor.gray.cgColor
        chooseView.layer.borderWidth = 1.0
        chooseView.layer.cornerRadius = chooseView.frame.width / 2.0
        chooseView.clipsToBounds = true
        setupHighlightState()
    }
    
    private func setupHighlightState() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.ccBlue
        selectedBackgroundView = backgroundView
        nameLabel.highlightedTextColor = .white
        numberLabel.highlightedTextColor = .white
    }
    
}
