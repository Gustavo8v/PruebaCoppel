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
    @IBOutlet weak var validateRequestLabel: UILabel!
    
    var presenter = PresenterLogin()
    var requestToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStyles()
        createToken()
    }
    
    func prepareStyles(){
        validateRequestLabel.isHidden = true
        logInButton.layer.cornerRadius = 8
        userNameTextField.delegate = self
        passwordNameTextField.delegate = self
        presenter.hiddeKeyboard(texfields: [userNameTextField, passwordNameTextField], view: self)
    }
    
    func changeValidateLabel(text: String, color: UIColor, isHidden: Bool) {
        DispatchQueue.main.async { [self] in
            validateRequestLabel.isHidden = isHidden
            validateRequestLabel.text = text
            validateRequestLabel.textColor = color
        }
    }
    
    func createToken(){
        presenter.createRequestToken { response in
            self.requestToken = response?.request_token
        } errorHandler: { error in
            self.createAlert(title: "Error al traer token", description: "")
        }
    }
    
    @IBAction func onClickLogIn(_ sender: Any) {
        changeValidateLabel(text: "Validando credenciales...", color: .white, isHidden: false)
        guard let safeUser = userNameTextField.text,
              let safePassword = passwordNameTextField.text,
              let safeToken = requestToken else {
                      changeValidateLabel(text: "favor de ingresar correo y contraseña", color: .red, isHidden: false)
                  return
              }
        let user = logInDTO(username: safeUser,
                            password: safePassword,
                            request_token: safeToken)
        presenter.logIn(user: user) { response in
            DispatchQueue.main.async {
                let token = CreateSessionDTO(request_token: response?.request_token)
                self.presenter.createSession(token: token) { [self] response in
                    changeValidateLabel(text: "", color: .white, isHidden: true)
                    DispatchQueue.main.async {
                        userNameTextField.text = nil
                        passwordNameTextField.text = nil
                        let vc = HomeViewController()
                        vc.delegate = self
                        presentViewController(view: vc, presentation: .overFullScreen)
                    }
                } errorHandler: { error in
                    self.changeValidateLabel(text: "tuvimos un error inesperado al iniciar sesión", color: .red, isHidden: false)
                }
            }
        } errorHandler: { error in
            self.changeValidateLabel(text: "Credenciales incorrectas", color: .red, isHidden: false)
        }
    }
}

extension LoginViewController: HomeViewControllerDelegate, UITextFieldDelegate {
    func generateNewToken() {
        self.createToken()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
