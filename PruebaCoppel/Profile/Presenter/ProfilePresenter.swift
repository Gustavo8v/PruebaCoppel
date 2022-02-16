//
//  ProfilePresenter.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//

import Foundation
import RealmSwift
import UIKit

class ProfilePresenter {
    
    var moviesData = try! Realm().objects(ResultsMoviesRealm.self)
    let userDefautls = UserDefaults.standard
    
    func getDataProfile(image: UIImageView, user: UILabel, vc: BaseViewController){
        guard let safeSessionID = userDefautls.object(forKey: "sessionID") as? String else { return }
        NetWorkManager.shared.getDetailProfile(session: safeSessionID) { profileResponse in
            DispatchQueue.main.async {
                image.downloaded(from: profileResponse?.avatar?.tmdb?.avatar_path ?? "", contentMode: .scaleAspectFill)
                user.text = profileResponse?.username
            }
        } errorHandler: { ProfileError in
            DispatchQueue.main.async {
                vc.createAlert(title: "Error", description: "Hubo un error al cargar tu información")
            }
        }
    }
    
    func hiddenValidate(validate: UILabel){
        validate.isHidden = moviesData.count == 0 ? false : true
    }
}
