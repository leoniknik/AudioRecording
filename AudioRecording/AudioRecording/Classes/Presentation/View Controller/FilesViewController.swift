//
//  FilesViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import BubbleTransition

final class FilesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    private var rootAssembly: RootAssembly
    private var model: FilesPresentationModel
    private let cellIdentifier = "\(AudioRecordCell.self)"
    private let cellHeight: CGFloat = 60
    
    private var playingRow: Int = -1
    let transition = BubbleTransition()
    
    init(rootAssembly: RootAssembly, model: FilesPresentationModel) {
        self.model = model
        self.rootAssembly = rootAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        model.obtainAudioRecords()
    }
    
    private func setupUI() {
        title = "Аудиозаписи"
        setupTableView()
        setupMicrophoneButton()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupMicrophoneButton() {
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: -2.5)
        bottomView.layer.shadowOpacity = 0.3
        bottomView.layer.shadowRadius = 2
        
        microphoneButton.layer.masksToBounds = false
        microphoneButton.layer.shadowColor = UIColor.red.cgColor
        microphoneButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        microphoneButton.layer.shadowOpacity = 0.5
        microphoneButton.layer.shadowRadius = 4
    }
    
    @IBAction func record(_ sender: UIButton) {
        guard let viewcontroller = rootAssembly.recordingAssembly.recordingViewController() else { return }
        viewcontroller.transitioningDelegate = self
        viewcontroller.modalPresentationStyle = .custom
        present(viewcontroller, animated: true, completion: nil)
    }
    
}

extension FilesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.audioRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AudioRecordCell else { return UITableViewCell() }
        
        cell.row = indexPath.item
        cell.delegate = self
        cell.configure(viewModel: model.audioRecords[indexPath.item])
        
        if indexPath.item == playingRow {
            cell.play()
        } else {
            cell.stop()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension FilesViewController: AudioRecordCellDelegate {
    
    func buttonPressed(row: Int) {
        playingRow = row
        tableView.reloadData()
    }
    
}
