//
//  DetailMovieViewController.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//

import UIKit

class DetailMovieViewController: BaseViewController {
    
    @IBOutlet weak var imageMoview: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var relaseDate: UILabel!
    @IBOutlet weak var originalLenguageMovie: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var overView: UITextView!
    
    var dataMovie: ResultsDTO?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDataMoview()
    }
    
    func setDataMoview(){
        guard let safeLenguage = dataMovie?.original_language,
              let safeVote = dataMovie?.vote_count else {
                  return
              }
        imageMoview.downloaded(from: dataMovie?.backdrop_path ?? "", contentMode: .scaleAspectFill)
        titleMovie.text = dataMovie?.title
        originalLenguageMovie.text = "lenguage original: \(safeLenguage)"
        voteCount.text = "Votos de los usurios: \(safeVote.description)"
        overView.text = dataMovie?.overview
        relaseDate.text = dataMovie?.release_date
    }
    
    func chargeData(data: ResultsDTO){
        dataMovie = data
    }
}
