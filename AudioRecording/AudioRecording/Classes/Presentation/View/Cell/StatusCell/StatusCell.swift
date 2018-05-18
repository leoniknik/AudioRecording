//
//  StatusCell.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 06.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupShadows()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        layer.backgroundColor = UIColor.clear.cgColor
        mainView.layer.cornerRadius = 12
        mainView.clipsToBounds = true
        
        statusView.layer.cornerRadius = statusView.frame.height / 2
        statusView.clipsToBounds = true
    }
    
    private func setupShadows() {
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowRadius = 5
        mainView.layer.masksToBounds = false
        
        statusView.layer.shadowColor = UIColor.red.cgColor
        statusView.layer.shadowOffset = CGSize(width: 0, height: 0)
        statusView.layer.shadowOpacity = 0.4
        statusView.layer.shadowRadius = 3
        statusView.layer.masksToBounds = false
    }
    
}
