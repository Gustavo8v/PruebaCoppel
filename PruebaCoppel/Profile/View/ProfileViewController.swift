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
        presenter.getDataProfile(image: imageUser, user: nameUser, vc: self)
        prepareCollectionView()
    }
    
    func prepareCollectionView(){
        imageUser.makeRounded()
        prepareCollectionProfile(collection: favouritsFilmsCollectionView, scroll: .horizontal, vc: self)
        favouritsFilmsCollectionView.delegate = self
        favouritsFilmsCollectionView.dataSource = self
        presenter.hiddenValidate(validate: validateFilms)
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
