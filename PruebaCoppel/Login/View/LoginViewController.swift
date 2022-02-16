//
//  LoginViewController.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordNameTextField: UITextField!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var validateRequestLabel: UILabel!
    
    var presenter = PresenterLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.validateSession(vc: self) {
            self.prepareStyles()
            self.presenter.createToken()
        }
    }
    
    func prepareStyles(){
        validateRequestLabel.isHidden = true
        logInButton.layer.cornerRadius = 8
        userNameTextField.delegate = self
        passwordNameTextField.delegate = self
        presenter.hiddeKeyboard(texfields: [userNameTextField, passwordNameTextField], view: self)
    }
    
    @IBAction func onClickLogIn(_ sender: Any) {
        presenter.startSessionWithLogin(validate: validateRequestLabel,
                                        user: userNameTextField.text,
                                        password: passwordNameTextField.text,
                                        vc: self)
        userNameTextField.text?.removeAll()
        passwordNameTextField.text?.removeAll()
    }
}

extension LoginViewController: HomeViewControllerDelegate, UITextFieldDelegate {
    func generateNewToken() {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
