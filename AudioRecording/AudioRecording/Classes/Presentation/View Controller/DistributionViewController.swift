//
//  DistributionViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import BGTableViewRowActionWithImage

class DistributionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rootAssembly: RootAssembly!
    var model: DistributionPresentationModel!
    let footerId = "\(DistributionFooterView.self)"
    let cellID = "\(DistributionCell.self)"
    let cellHeight = 60
    
    init(rootAssembly: RootAssembly, model: DistributionPresentationModel) {
        self.model = model
        self.rootAssembly = rootAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.obtainDistributions()
        tableView.reloadData()
    }
    
    func setupUI() {
        navigationItem.title = "Групповые рассылки"
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: footerId, bundle: nil), forHeaderFooterViewReuseIdentifier: footerId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }

}

extension DistributionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let distribution = model.distributions[indexPath.item]
        let viewController = rootAssembly.contactsAssembly.contactsViewController(contacts: distribution.contacts)
        viewController.hidesBottomBarWhenPushed = true
        viewController.isNotNewDistribution = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) as? DistributionFooterView else { return UIView() }
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { [weak self] (action, indexPath) in
            self?.model.delete(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Изменить") { [weak self] (action, indexPath) in
            self?.showAlert(indexPath: indexPath)
        }
        
        delete.backgroundColor = .ccRed
        edit.backgroundColor = .ccYellow
        
        return [delete, edit]
    }
    
    func showAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Рассылка", message: "Введите название", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
            guard let textField = alert?.textFields?[0], !(textField.text?.isEmpty ?? true) else {
                self?.showError("Вы не ввели название")
                return
            }
            self?.model.change(title: textField.text ?? "", at: indexPath.item)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


extension DistributionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.distributions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? DistributionCell else { return UITableViewCell() }
        let distribution = model.distributions[indexPath.item]
        cell.titleLabel.text = distribution.title
        cell.numberLabel.text = "\(distribution.contacts.count)"
        return cell
    }
}

extension DistributionViewController: DistributionFooterViewDelegate {
    func addTapped() {
        let viewController = rootAssembly.contactsAssembly.contactsViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DistributionViewController: DistributionPresentationModelDelegate {
    func nameDidChanged(at item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
