//
//  HomeViewController.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//
protocol HomeViewControllerDelegate: AnyObject{
    func generateNewToken()
}

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet private weak var filmsSegmentControl: UISegmentedControl!
    @IBOutlet private weak var filmsCollectionView: UICollectionView!
    
    var presenter = HomePresenter()
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        presenter.prepareCollectionProfile(collection: filmsCollectionView, scroll: .vertical)
        filmsCollectionView.delegate = self
        filmsCollectionView.dataSource = self
        configureNavBar(background: .darkGray, tintColor: .white, title: "TV Shows")
        prepareStyles()
        setRightButton(action: #selector(actionRightBarButton))
        presenter.getDataMoview(vc: self, collection: filmsCollectionView)
    }
    
    func prepareStyles(){
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    @objc func actionRightBarButton(){
        presenter.actionBarButton(vc: self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.moviesData?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let cellMovie = collectionView.dequeueReusableCell(withReuseIdentifier: DetailFilmCollectionViewCell.identifier, for: indexPath) as? DetailFilmCollectionViewCell else { return cell }
        guard let dataItem = presenter.moviesData?[indexPath.item] else { return cell }
        cellMovie.configureItem(data: dataItem)
        cellMovie.layer.cornerRadius = 14
        return cellMovie
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataItem = self.presenter.moviesData?[indexPath.item] else { return }
        presenter.onClickActionMovie(vc: self, dataItem: dataItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = UIScreen.main.bounds
        return CGSize(width: frame.width * 0.42, height: (frame.width * 0.42) * 2.5)
    }
}
