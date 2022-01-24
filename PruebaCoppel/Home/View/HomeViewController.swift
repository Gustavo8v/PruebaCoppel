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
    var pageData = "1"
    var moviesData: [ResultsDTO]?
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureNavBar(background: .darkGray, tintColor: .white, title: "TV Shows")
        prepareStyles()
        getDataMovies()
        prepareCollectionView()
        setRightButton(action: #selector(actionBarButton))
    }
    
    func prepareStyles(){
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    @objc func actionBarButton(){
        let seeProfile = UIAlertAction(title: "ViewProfile", style: .default) { goToProfile in
            self.present(ProfileViewController(), animated: true, completion: nil)
        }
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) { closeSession in
            self.presenter.closeSession(session: NetWorkManager.shared.sessionID) { response in
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.delegate?.generateNewToken()
                    }
                }
            } errorHandler: { error in
                DispatchQueue.main.async {
                    self.createAlert(title: "Error", description: "Tuvimos un problema al cerrar sesión, por favor intente mas tarde")
                }
            }
        }
        createAlertSheet(firstAction: seeProfile, secondAction: logOut)
    }
    
    func getDataMovies(){
        presenter.getMovies(page: pageData) { response in
            self.moviesData = response?.results
            DispatchQueue.main.async {
                self.filmsCollectionView.reloadData()
            }
        } errorHandler: { error in
            DispatchQueue.main.async {
                self.createAlert(title: "Error", description: "Hubo un error al cargar la información")
            }
        }
    }
    
    func prepareCollectionView(){
        prepareCollectionViews(collection: filmsCollectionView, scroll: .vertical)
        filmsCollectionView.delegate = self
        filmsCollectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let cellMovie = collectionView.dequeueReusableCell(withReuseIdentifier: DetailFilmCollectionViewCell.identifier, for: indexPath) as? DetailFilmCollectionViewCell else { return cell }
        guard let dataItem = moviesData?[indexPath.item] else { return cell }
        cellMovie.configureItem(data: dataItem)
        cellMovie.layer.cornerRadius = 14
        return cellMovie
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataItem = self.moviesData?[indexPath.item] else { return }
        let seeDetail = UIAlertAction(title: "See Detail", style: .default) { onClickSeeDetail in
            let vc = DetailMovieViewController()
            vc.chargeData(data: dataItem)
            self.pushViewController(vc: vc)
        }
        let saveMovie = UIAlertAction(title: "Add Favourites", style: .default) { onClickSaveMovie in
            self.presenter.saveFavouriteMovie(movie: dataItem) { filmError in
                self.createAlert(title: "¡Ups!", description: "Al parecer este título ya se encunetra en favoritos")
            }
        }
       createAlertSheet(firstAction: seeDetail, secondAction: saveMovie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = UIScreen.main.bounds
        return CGSize(width: frame.width * 0.42, height: (frame.width * 0.42) * 2.5)
    }
}
