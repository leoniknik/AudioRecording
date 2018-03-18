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
        bindEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.obtainAudioRecords()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        title = "Аудиозаписи"
        setupTableView()
        setupMicrophoneButton()
    }
    
    private func bindEvents() {
        model.changeStateHandler = { [unowned self] status in
            switch status {
            case .loading:
                break
            case .rich:
                self.tableView.reloadData()
            case .error(let message):
                print(message)
            }
        }
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
        if playingRow != -1 {
            model.stopRecord(item: playingRow)
            playingRow = -1
//            tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteRecord(item: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FilesViewController: AudioRecordCellDelegate {
    
    func buttonPressed(row: Int) {
        if playingRow == row {
            model.stopRecord(item: row)
        } else {
            model.playRecord(item: row)
        }
        playingRow = row
        tableView.reloadData()
    }
    
}

extension FilesViewController: FilesPresentationModelDelegate {
    
    func playingFinished() {
        playingRow = -1
        tableView.reloadData()
    }
    
}
