//
//  PresenterLogin.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import Foundation
import UIKit

class PresenterLogin {
    
    var token = ""
    let userDefaults = UserDefaults.standard
    
    func validateSession(vc: BaseViewController, outSession: @escaping() -> Void){
        if userDefaults.object(forKey: "sessionID") == nil {
            outSession()
        } else {
            presentHome(vc: vc)
        }
    }
    
    func hiddeKeyboard(texfields: [UITextField], view: LoginViewController){
        for texfield in texfields {
            texfield.delegate = view.self
        }
    }
    
    func createToken(){
        NetWorkManager.shared.createToken { responseToken in
            self.token = responseToken?.request_token ?? ""
        } errorHandler: { errorToken in
            print(errorToken.debugDescription)
        }
    }
    
    func changeValidateLabel(validate: UILabel,text: String, color: UIColor, isHidden: Bool) {
        DispatchQueue.main.async {
            validate.isHidden = isHidden
            validate.text = text
            validate.textColor = color
        }
    }
    
    func presentHome(vc: BaseViewController){
        DispatchQueue.main.async {
            let homeVC = HomeViewController(nibName: nil, bundle: nil)
            homeVC.modalPresentationStyle = .overFullScreen
            let navigationController = UINavigationController()
            navigationController.viewControllers = [homeVC]
            navigationController.modalPresentationStyle = .overFullScreen
            vc.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func startSessionWithLogin(validate: UILabel, user: String?, password: String?, vc: BaseViewController){
        changeValidateLabel(validate: validate, text: "Validando credenciales...", color: .white, isHidden: false)
        if user == "" && password == "" {
            changeValidateLabel(validate: validate, text: "favor de ingresar correo y contraseña", color: .red, isHidden: false)
            return
        }
        let user = logInDTO(username: user,
                            password: password,
                            request_token: self.token)
        NetWorkManager.shared.logIn(user: user) { responseLogin in
            DispatchQueue.main.async {
                let token = CreateSessionDTO(request_token: responseLogin?.request_token)
                NetWorkManager.shared.createSession(token: token) { responseSession in
                    guard let sessionID = responseSession?.session_id else { return }
                    self.userDefaults.set(sessionID, forKey: "sessionID")
                    self.changeValidateLabel(validate: validate, text: "", color: .white, isHidden: true)
                    self.presentHome(vc: vc)
                } errorHandler: { errorSession in
                    self.changeValidateLabel(validate: validate, text: "tuvimos un error inesperado al iniciar sesión", color: .red, isHidden: false)
                }
            }
        } errorHandler: { errorLogin in
            self.changeValidateLabel(validate: validate, text: "Credenciales incorrectas", color: .red, isHidden: false)
        }
    }
}
