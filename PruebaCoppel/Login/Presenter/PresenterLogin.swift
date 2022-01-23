//
//  PresenterLogin.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import Foundation

class PresenterLogin {
    
    func createRequestToken(succesHandelr: @escaping(ModelGenericRequest?) -> Void, errorHandler: @escaping(Error?) -> Void){
        NetWorkManager.shared.createToken(succesHandeler: succesHandelr, errorHandler: errorHandler)
    }
    
    func logIn(user: logInDTO?, succesHandelr: @escaping(ModelGenericRequest?) -> Void, errorHandler: @escaping(Error?) -> Void){
        NetWorkManager.shared.logIn(user: user, succesHandeler: succesHandelr, errorHandler: errorHandler)
    }
    
    func createSession(token: CreateSessionDTO?, succesHandeler: @escaping (ModelGenericRequest?) -> Void, errorHandler: @escaping (Error?) -> Void){
        NetWorkManager.shared.createSession(token: token, succesHandeler: succesHandeler, errorHandler: errorHandler)
    }
}
