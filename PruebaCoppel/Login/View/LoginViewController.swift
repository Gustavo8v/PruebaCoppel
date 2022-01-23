//
//  LoginViewController.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordNameTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    var presenter = PresenterLogin()
    var requestToken: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStyles()
        createToken()
    }
    
    func prepareStyles(){
        logInButton.layer.cornerRadius = 8
    }
    
    func createToken(){
        presenter.createRequestToken { response in
            self.requestToken = response?.request_token
        } errorHandler: { error in
            self.createAlert(title: "Error al traer token", description: "")
        }
    }
    
    @IBAction func onClickLogIn(_ sender: Any) {
        guard let safeUser = userNameTextField.text,
              let safePassword = passwordNameTextField.text,
                let safeToken = requestToken else {
                    DispatchQueue.main.async {
                        self.createAlert(title: "UPS", description: "estas bien meco")
                    }
                    return
                }
        let user = logInDTO(username: safeUser,
                            password: safePassword,
                            request_token: safeToken)
        presenter.logIn(user: user) { response in
            DispatchQueue.main.async {
                let token = CreateSessionDTO(request_token: response?.request_token)
                self.presenter.createSession(token: token) { response in
                    DispatchQueue.main.async {
                        self.createAlert(title: "Exito", description: "ya entraste, joto")
                    }
                } errorHandler: { error in
                    DispatchQueue.main.async {
                        self.createAlert(title: "UPS", description: "estas bien meco")
                    }
                }
            }
        } errorHandler: { error in
            self.createAlert(title: "Error", description: "Error de credenciales")
        }
    }
}
