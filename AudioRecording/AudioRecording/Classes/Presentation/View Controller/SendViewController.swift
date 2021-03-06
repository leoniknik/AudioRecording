//
//  SendViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 28.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    //view for money
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var bottomMoneyViewConstraint: NSLayoutConstraint!
    
    var rootAssembly: RootAssembly!
    var model: SendPresentationModel!
    var cellID = "\(NumberCell.self)"
    
    init(rootAssembly: RootAssembly, model: SendPresentationModel) {
        self.model = model
        self.rootAssembly = rootAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let keyboardButton = UIBarButtonItem(image: #imageLiteral(resourceName: "dollar").withRenderingMode(.automatic), style: .done, target: self, action: #selector(showCost))
        navigationItem.setRightBarButton(keyboardButton , animated: false)
    }
    
    @objc func showCost() {
        model.getCost()
    }
    
    private func setupUI() {
        navigationItem.title = "Отправка сообщения"
        setupSendButton()
        setupTopView()
        setupTableView()
        addBackButton()
    }
    
    private func setupSendButton() {
        sendButton.layer.cornerRadius = 20
        sendButton.clipsToBounds = true
        sendButton.backgroundColor = .ccGreen
    }
    
    private func setupTopView() {
        musicImage.layer.cornerRadius = musicImage.frame.width / 2
        musicImage.clipsToBounds = true
        
        topView.layer.cornerRadius = 12
        topView.clipsToBounds = true
        
        topView.layer.shadowColor = UIColor.gray.cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 0)
        topView.layer.shadowOpacity = 0.6
        topView.layer.shadowRadius = 6
        topView.layer.masksToBounds = false
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openRecordsScreen))
        topView.addGestureRecognizer(gesture)
    }
    
    @objc func openRecordsScreen() {
        let viewController = rootAssembly.filesAssembly.filesViewController()
        viewController.isFromMessage = true
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
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
    
    @IBAction func closeMoneyView(_ sender: UIButton) {
        self.bottomMoneyViewConstraint.constant = -100
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showMoneyView() {
        self.bottomMoneyViewConstraint.constant = 0
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func bindEvents() {
        model.changeStateHandler = { [unowned self] status in
            switch status {
            case .loading:
                ModalLoadingIndicator.show()
            case .richCost:
                if let result = self.model.cost {
                    self.moneyLabel.text = "\(result.cost)"
                    self.showMoneyView()
                }
                ModalLoadingIndicator.hide()
            case .richCall:
                ModalLoadingIndicator.hide()
                self.showAlert()
            case .error(let message):
                self.showError(message)
                ModalLoadingIndicator.hide()
            }
        }
    }
    
    @IBAction func send(_ sender: UIButton) {
        model.send()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Рассылка", message: "Файл отправлен", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SendViewController: UITableViewDelegate {
    
}

extension SendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.message.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NumberCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.nameLabel.text = model.message.contacts[indexPath.item].name
        cell.numberLabel.text = model.message.contacts[indexPath.item].number
        return cell
    }
}

extension SendViewController: FilesViewControllerDelegate {
    func recordDidSelected(_ record: RecordViewModel) {
        model.message.record = record
        recordLabel.text = "\(record.name) - \(record.duration)"
    }
}
