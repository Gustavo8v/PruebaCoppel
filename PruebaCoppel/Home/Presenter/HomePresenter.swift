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
    
    func getMovies(page: String, succesHandeler: @escaping (MoviesDTO?) -> Void, errorHandler: @escaping (Error?) -> Void){
        NetWorkManager.shared.getMovies(page: page, succesHandeler: succesHandeler, errorHandler: errorHandler)
    }
    
    func closeSession(session: CloseSessionDTO?, succesHandeler: @escaping (ModelGenericRequest?) -> Void, errorHandler: @escaping (Error?) -> Void){
        NetWorkManager.shared.closeSession(session: session, succesHandeler: succesHandeler, errorHandler: errorHandler)
    }
    
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
}
