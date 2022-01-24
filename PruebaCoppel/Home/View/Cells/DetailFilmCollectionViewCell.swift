//
//  DetailFilmCollectionViewCell.swift
//  PruebaCoppel
//
//  Created by Gustavo on 23/01/22.
//

import UIKit

class DetailFilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var titieMovie: UILabel!
    @IBOutlet private weak var dateMovie: UILabel!
    @IBOutlet private weak var filmRating: UILabel!
    @IBOutlet private weak var reviewOfTheMovie: UITextView!
    
    static let identifier = "DetailFilmCollectionViewCell"

    override func awakeFromNib(){
        super.awakeFromNib()
        prepareStyles()
    }
    
    func prepareStyles(){
        imageMovie.layer.cornerRadius = 14
        reviewOfTheMovie.isEditable = false
    }
    
    func configureItem(data: ResultsDTO){
        imageMovie.downloaded(from: data.backdrop_path ?? "", contentMode: .scaleToFill)
        titieMovie.text = data.title
        dateMovie.text = data.release_date
        filmRating.text = data.vote_average?.description
        reviewOfTheMovie.text = data.overview
    }
    
    func configureItemWithRealm(data: ResultsMoviesRealm){
        imageMovie.downloaded(from: data.backdrop_path, contentMode: .scaleToFill)
        titieMovie.text = data.title
        dateMovie.text = data.release_date
        filmRating.text = data.vote_average.description
        reviewOfTheMovie.text = data.overview
    }
}
