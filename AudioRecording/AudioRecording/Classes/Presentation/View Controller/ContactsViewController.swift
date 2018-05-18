//
//  ContactsViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

final class ContactsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    let cellID = "\(ContactCell.self)"
    var rootAssembly: RootAssembly!
    var model: ContactsPresentationModel!
    
    var isNotNewDistribution = false
    
    init(rootAssembly: RootAssembly, model: ContactsPresentationModel) {
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
        bindEvents()
        model.obtainContacts()
    }

    func setupTableView() {
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 56
        tableView.tableFooterView = UIView()
    }
    
    func setupUI() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Выберите контакты"
        addBackButton()
        addKeyboardBarItem()
        setupBottom()
    }
    
    private func setupBottom() {
        nextButton.backgroundColor = .ccGreen
        nextButton.layer.cornerRadius = 20
        nextButton.clipsToBounds = true
    }
    
    private func addKeyboardBarItem() {
        let keyboardButton = UIBarButtonItem(image: #imageLiteral(resourceName: "keyboard").withRenderingMode(.automatic), style: .done, target: self, action: #selector(openKeyboard))
        navigationItem.setRightBarButton(keyboardButton , animated: false)
    }
    
    @objc func openKeyboard() {
        let viewController = KeyboardViewController()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    private func bindEvents() {
        model.changeStateHandler = { [unowned self] status in
            switch status {
            case .loading:
                ModalLoadingIndicator.show()
            case .rich:
                self.tableView.reloadData()
                ModalLoadingIndicator.hide()
            case .error(let message):
                self.showError(message)
                ModalLoadingIndicator.hide()
            }
        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if model.choosenContacts.count == 0 {
            showError("Выберите хотя бы один номер")
        } else {
            if isNotNewDistribution {
                showMessageScreen()
            } else {
                showAlert()
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Рассылка", message: "Введите название", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
            guard let textField = alert?.textFields?[0], !(textField.text?.isEmpty ?? true) else {
                self?.showError("Вы не ввели название")
                return
            }
            if let flag = self?.model.saveDistribution(title: textField.text ?? ""), flag == true {
                self?.showMessageScreen()
            } else {
                self?.showError("Рассылка с таким именем уже существует")
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessageScreen() {
        let message = MessageViewModel(contacts: model.choosenContacts)
        let viewcontroller = rootAssembly.sendAssembly.sendViewController(message: message)
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.contacts[indexPath.item].isChoosen = !model.contacts[indexPath.item].isChoosen
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ContactCell else { return UITableViewCell() }
        let contact = model.contacts[indexPath.item]
        if contact.isChoosen {
            cell.chooseView.backgroundColor = .ccBlue
            cell.chooseView.layer.borderColor = UIColor.white.cgColor
        } else {
            cell.chooseView.backgroundColor = UIColor.white
            cell.chooseView.layer.borderColor = UIColor.gray.cgColor
        }
        cell.nameLabel.text = contact.name
        cell.numberLabel.text = contact.number
        return cell
    }
}

extension ContactsViewController: KeyboardViewControllerDelegate {
    func numberDidEntered(number: String) {
        model.addCustomNumber(number: number)
    }
}
