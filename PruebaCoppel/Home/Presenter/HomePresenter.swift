//
//  HomePresenter.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//

import UIKit

class HomePresenter {
    
    func getMovies(page: String, succesHandeler: @escaping (MoviesDTO?) -> Void, errorHandler: @escaping (Error?) -> Void){
        NetWorkManager.shared.getMovies(page: page, succesHandeler: succesHandeler, errorHandler: errorHandler)
    }
    
    func closeSession(session: CloseSessionDTO?, succesHandeler: @escaping (ModelGenericRequest?) -> Void, errorHandler: @escaping (Error?) -> Void){
        NetWorkManager.shared.closeSession(session: session, succesHandeler: succesHandeler, errorHandler: errorHandler)
    }
}
