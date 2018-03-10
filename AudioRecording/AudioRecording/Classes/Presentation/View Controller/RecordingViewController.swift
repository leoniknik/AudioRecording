//
//  RecordingViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 10.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

final class RecordingViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
