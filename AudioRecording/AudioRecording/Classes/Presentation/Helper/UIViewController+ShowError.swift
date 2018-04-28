//
//  UIViewController+ShowError.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 22.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: error,
                                      preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
        })
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
}
