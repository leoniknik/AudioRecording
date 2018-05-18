//
//  StatusViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 06.05.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "\(StatusCell.self)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        navigationItem.title = "Статусы рассылок"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }

}

extension StatusViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension StatusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? StatusCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
