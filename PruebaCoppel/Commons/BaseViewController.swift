//
//  BaseViewController.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    func createAlert(title: String, description: String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
