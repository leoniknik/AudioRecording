//
//  LoginViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var rootAssembly: RootAssembly!
    var model: LoginPresentationModel!
    
    private var disposeBag = DisposeBag()
    
    init(rootAssembly: RootAssembly, model: LoginPresentationModel) {
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
        validateForm()
    }
    
    func setupUI() {
        setupFormView()
        setupTextFields()
        setupButton()
    }
    
    func setupFormView() {
        formView.backgroundColor = .white
        formView.layer.borderWidth = 1.5
        formView.layer.borderColor = UIColor.gray.cgColor
        formView.layer.cornerRadius = 12
        formView.clipsToBounds = true
        
        formView.layer.shadowColor = UIColor.gray.cgColor
        formView.layer.shadowOffset = CGSize(width: 0, height: 0)
        formView.layer.shadowOpacity = 0.6
        formView.layer.shadowRadius = 7
        formView.layer.masksToBounds = false
    }
    
    func setupTextFields() {
        loginTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        loginTextField.placeholder = "Логин"
        passwordTextField.placeholder = "Пароль"
    }
    
    func setupButton() {
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 12
        
        loginButton.backgroundColor = UIColor.ccGreen
        loginButton.layer.shadowColor = UIColor.ccGreen.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        loginButton.layer.shadowOpacity = 0.6
        loginButton.layer.shadowRadius = 7
        loginButton.layer.masksToBounds = false
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        model.authUser(byLogin: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    private func bindEvents() {
        model.changeStateHandler = { [unowned self] status in
            switch status {
            case .loading:
                ModalLoadingIndicator.show()
            case .rich:
                self.openMainScreen()
                ModalLoadingIndicator.hide()
            case .error(let message):
                self.showError(message)
                ModalLoadingIndicator.hide()
            }
        }
    }
    
    private func openMainScreen() {
        if model.isLogined {
            let tabBarController = setupTabBarController()
            present(tabBarController, animated: true, completion: nil)
        } else {
            showError("Неверный логин или пароль")
        }
    }
    
    private func validateForm() {
        loginButton.isEnabled = false
        
        Observable.combineLatest(
            loginTextField.rx.text.orEmpty,
            passwordTextField.rx.text.orEmpty,
            resultSelector: { (login, password) -> Bool in
                return login.count > 0 && password.count > 0
        })
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

}
