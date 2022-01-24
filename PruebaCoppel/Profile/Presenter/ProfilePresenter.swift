//
//  ProfilePresenter.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//

import Foundation
import RealmSwift

class ProfilePresenter {
    
    var moviesData = try! Realm().objects(ResultsMoviesRealm.self)
    
    func getDataProfile(session: String, succesHandeler: @escaping (InfoProfileDTO?) -> Void, errorHandler: @escaping (Error?) -> Void){
        NetWorkManager.shared.getDetailProfile(session: session, succesHandeler: succesHandeler, errorHandler: errorHandler)
    }
}
