//
//  DistributionViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class DistributionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rootAssembly: RootAssembly!
    var model: DistributionPresentationModel!
    let footerId = "\(DistributionFooterView.self)"
    
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
    
    func setupUI() {
        navigationItem.title = "Групповые рассылки"
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: footerId, bundle: nil), forHeaderFooterViewReuseIdentifier: footerId)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension DistributionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) as? DistributionFooterView else { return UIView() }
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}

extension DistributionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension DistributionViewController: DistributionFooterViewDelegate {
    func addTapped() {
        let viewController = rootAssembly.contactsAssembly.contactsViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
