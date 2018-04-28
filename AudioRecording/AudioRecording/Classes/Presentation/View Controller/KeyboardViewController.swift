//
//  KeyboardViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import InputMask

protocol KeyboardViewControllerDelegate: class {
    func numberDidEntered(number: String)
}

class KeyboardViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet var buttons: [UIButton]!
    
    private var maskedDelegate: MaskedTextFieldDelegate!
    
    weak var delegate: KeyboardViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red:16/255.0, green:48/255.0, blue:101/255.0, alpha:1.0)
        
        for button in buttons {
            button.backgroundColor = UIColor.ccBlue
            button.layer.cornerRadius = button.frame.width / 2.0
            button.clipsToBounds = true
        }
        
        numberTextField.layer.borderColor = UIColor.clear.cgColor
        numberTextField.backgroundColor = .clear
        numberTextField.textColor = .white
        numberTextField.borderStyle = .none
        numberTextField.isEnabled = false
        
        doneButton.layer.cornerRadius = 15
        doneButton.clipsToBounds = true
        doneButton.backgroundColor = UIColor.ccBlue
        
        addCloseButton()
    }
    
    func addCloseButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(#imageLiteral(resourceName: "ic_close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        if #available(iOS 11.0, *) {
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        } else {
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeScreen))
        button.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func numberTapped(_ sender: UIButton) {
        let char = sender.titleLabel?.text ?? ""
        var phone = numberTextField.text ?? ""
        phone.append(char)
        
        let mask: Mask = try! Mask(format: "+7 ([000]) [000] [00] [00]")
        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: phone,
                caretPosition: phone.endIndex
            ),
            autocomplete: true
        )
        let output: String = result.formattedText.string
        
        numberTextField.text = output
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        guard var number = numberTextField.text, number.count != 0 else { return }
        number.removeLast()
        numberTextField.text = number
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        if numberTextField.text?.count != 18 {
            showError("Неправильный формат номера телефона")
        } else {
            delegate?.numberDidEntered(number: numberTextField.text ?? "")
            closeScreen()
        }
    }
    
    @objc func closeScreen() {
        dismiss(animated: true, completion: nil)
    }
    
}
