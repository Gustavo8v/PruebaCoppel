//
//  ProfileViewController.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet private weak var imageUser: UIImageView!
    @IBOutlet private weak var nameUser: UILabel!
    @IBOutlet private weak var validateFilms: UILabel!
    @IBOutlet private weak var favouritsFilmsCollectionView: UICollectionView!
    
    var presenter = ProfilePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        prueba()
        prepareCollectionView()
    }
    
    func prepareCollectionView(){
        imageUser.makeRounded()
        prepareCollectionViews(collection: favouritsFilmsCollectionView)
    }
    
    func prueba(){
        guard let safeSessionID = NetWorkManager.shared.sessionID?.session_id else { return }
        presenter.getDataProfile(session: safeSessionID) { response in
            DispatchQueue.main.async { [self] in
                imageUser.downloaded(from: response?.avatar?.tmdb?.avatar_path ?? "", contentMode: .scaleToFill)
                nameUser.text = response?.username
            }
        } errorHandler: { error in
            DispatchQueue.main.async { [self] in
                createAlert(title: "Error", description: "Hubo un error al cargar tu información")
            }
        }
    }
}
