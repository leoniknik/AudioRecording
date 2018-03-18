//
//  AudioRecordCell.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 10.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

protocol AudioRecordCellDelegate: class {
    func buttonPressed(row: Int)
}

final class AudioRecordCell: UITableViewCell {

    var row: Int = 0
    weak var delegate: AudioRecordCellDelegate?
    
    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var recordTitle: UILabel!
    @IBOutlet weak var recordDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(row: row)
    }
    
    func configure(viewModel: RecordViewModel) {
        recordTitle.text = viewModel.recordTitle
        recordDuration.text = "\(viewModel.duration)"
    }
    
    func play() {
        cellButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    func stop() {
        cellButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
    }
}
