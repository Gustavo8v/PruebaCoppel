//
//  HomePresenter.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//

import UIKit
import RealmSwift

class HomePresenter {
    
    let realm = try! Realm()
    var dataMovie: ResultsMoviesRealm?
    var filmsData = try! Realm().objects(ResultsMoviesRealm.self)
    var moviesData: [ResultsDTO]?
    let userDefaults = UserDefaults.standard
    
    func saveFavouriteMovie(movie: ResultsDTO, errorHandeler: @escaping (ResultsMoviesRealm?) -> Void){
        var save = true
        for film in filmsData {
            if film.id == movie.id {
                save = false
                errorHandeler(film)
            }
        }
        if save {
            try! realm.write{
                let newMovie = ResultsMoviesRealm()
                newMovie.adult = movie.adult!
                newMovie.backdrop_path = movie.backdrop_path!
                newMovie.id = movie.id!
                newMovie.original_language = movie.original_language!
                newMovie.original_title = movie.original_title!
                newMovie.overview = movie.overview!
                newMovie.popularity = movie.popularity!
                newMovie.poster_path = movie.poster_path!
                newMovie.release_date = movie.release_date!
                newMovie.title = movie.title!
                newMovie.video = movie.video!
                newMovie.vote_average = movie.vote_average!
                newMovie.vote_count = movie.vote_count!
                realm.add(newMovie)
                dataMovie = newMovie
            }
        }
    }
    
    func getDataMoview(vc: HomeViewController, collection: UICollectionView){
        NetWorkManager.shared.getMovies(page: "1") { response in
            self.moviesData = response?.results
            DispatchQueue.main.async {
                collection.reloadData()
            }
        } errorHandler: { error in
            DispatchQueue.main.async {
                vc.createAlert(title: "Error",
                               description: "Hubo un error al cargar la información")
            }
        }
    }
    
    func prepareCollectionProfile(collection: UICollectionView, scroll: UICollectionView.ScrollDirection){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = scroll
        flowLayout.minimumLineSpacing = 30
        collection.collectionViewLayout = flowLayout
        collection.register(UINib(nibName: DetailFilmCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DetailFilmCollectionViewCell.identifier)
    }
    
    @objc func actionBarButton(vc: BaseViewController){
        let seeProfile = UIAlertAction(title: "ViewProfile", style: .default) { goToProfile in
            vc.present(ProfileViewController(), animated: true, completion: nil)
        }
        
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) { closeSession in
            let session = CloseSessionDTO(session_id: self.userDefaults.object(forKey: "sessionID") as? String)
            NetWorkManager.shared.closeSession(session: session) { closeResponse in
                self.userDefaults.set(nil, forKey: "sessionID")
                DispatchQueue.main.async {
                    vc.dismissView()
                }
            } errorHandler: { errorResponse in
                DispatchQueue.main.async {
                    vc.createAlert(title: "Error", description: "Tuvimos un problema al cerrar sesión, por favor intente mas tarde")
                }
            }
        }
        vc.createAlertSheet(firstAction: seeProfile, secondAction: logOut)
    }
    
    func onClickActionMovie(vc: BaseViewController, dataItem: ResultsDTO){
        let seeDetail = UIAlertAction(title: "See Detail", style: .default) { onClickSeeDetail in
            let view = DetailMovieViewController()
            view.chargeData(data: dataItem)
            vc.pushViewController(vc: view)
        }
        let saveMovie = UIAlertAction(title: "Add Favourites", style: .default) { onClickSaveMovie in
            self.saveFavouriteMovie(movie: dataItem) { filmError in
                vc.createAlert(title: "¡Ups!", description: "Al parecer este título ya se encunetra en favoritos")
            }
        }
        vc.createAlertSheet(firstAction: seeDetail, secondAction: saveMovie)
    }
    
    func getTopRateMovies(vc: HomeViewController, collection: UICollectionView){
        NetWorkManager.shared.getTopRates(page: "1") { respnseRated in
            self.moviesData = respnseRated?.results
            DispatchQueue.main.async {
                collection.reloadData()
            }
        } errorHandler: { errorRated in
            DispatchQueue.main.async {
                vc.createAlert(title: "Error",
                               description: "Hubo un error al cargar la información")
            }
        }
    }
}
