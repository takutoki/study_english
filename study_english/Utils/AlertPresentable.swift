//
//  AlertPresentable.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/24.
//

import Foundation
import UIKit

protocol AlertPresentable: UIViewController {
    
    func presentAlert(title: String, message: String)
}

extension AlertPresentable {
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        DispatchQueue.main.sync {
            present(alert, animated: true, completion: nil)
        }
    }
}
