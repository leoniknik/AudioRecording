//
//  UIViewController+BackButton.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 23.04.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

extension UIViewController {
    func addBackButton() {
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
