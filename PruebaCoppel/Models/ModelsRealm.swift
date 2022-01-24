//
//  ModelsRealm.swift
//  PruebaCoppel
//
//  Created by Gustavo on 24/01/22.
//

import Foundation
import RealmSwift

class ResultsMoviesRealm: Object {
    @objc dynamic var adult = false
    @objc dynamic var backdrop_path = ""
    @objc dynamic var id = 0
    @objc dynamic var original_language = ""
    @objc dynamic var original_title = ""
    @objc dynamic var overview = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var poster_path = ""
    @objc dynamic var release_date = ""
    @objc dynamic var title = ""
    @objc dynamic var video = false
    @objc dynamic var vote_average = 0.0
    @objc dynamic var vote_count = 0
}
