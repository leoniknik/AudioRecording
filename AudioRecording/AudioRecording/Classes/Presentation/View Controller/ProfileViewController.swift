//
//  ProfileViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 29.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var exitButton: UIButton!
    
    var rootAssembly: RootAssembly!
    var model: ProfilePresentationModel!
    
    init(rootAssembly: RootAssembly, model: ProfilePresentationModel) {
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
        model.getBalance()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        topView.backgroundColor = .ccBlue
        
        exitButton.layer.borderColor = UIColor.red.cgColor
        exitButton.layer.cornerRadius = 12
        exitButton.layer.borderWidth = 1.5
        exitButton.clipsToBounds = true
        exitButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    @IBAction func exitTapped(_ sender: UIButton) {
        model.logout()
    }
    
    private func bindEvents() {
        model.changeStateHandler = { [unowned self] status in
            switch status {
            case .loading:
                ModalLoadingIndicator.show()
            case .richBalance:
                self.moneyLabel.text = "\(Int(self.model.balance))"
                ModalLoadingIndicator.hide()
            case .richLogout:
                ModalLoadingIndicator.hide()
                self.dismiss(animated: true, completion: nil)
            case .error(let message):
                self.showError(message)
                ModalLoadingIndicator.hide()
            }
        }
    }

}
