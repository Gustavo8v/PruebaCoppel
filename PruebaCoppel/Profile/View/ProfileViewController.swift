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
        prepareCollectionViews(collection: favouritsFilmsCollectionView, scroll: .horizontal)
        favouritsFilmsCollectionView.delegate = self
        favouritsFilmsCollectionView.dataSource = self
        validateFilms.isHidden = presenter.moviesData.count == 0 ? false : true
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.moviesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let cellMovie = collectionView.dequeueReusableCell(withReuseIdentifier: DetailFilmCollectionViewCell.identifier, for: indexPath) as? DetailFilmCollectionViewCell else { return cell }
        cellMovie.configureItemWithRealm(data: presenter.moviesData[indexPath.item])
        cellMovie.layer.cornerRadius = 8
        return cellMovie
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = favouritsFilmsCollectionView.bounds
        return CGSize(width: frame.width * 0.55, height: frame.height * 0.99)
    }
}
