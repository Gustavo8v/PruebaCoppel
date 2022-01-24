//
//  ModelsRequest.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import Foundation

struct ModelGenericRequest: Codable {
    var success: Bool?
    var expires_at: String?
    var request_token: String?
    var session_id: String?
}

struct logInDTO: Codable {
    var username: String?
    var password: String?
    var request_token: String?
}

struct CreateSessionDTO: Codable {
    var request_token: String?
}

struct CloseSessionDTO: Codable {
    var session_id: String?
}

struct MoviesDTO: Codable {
    var page: Int?
    var results: [ResultsDTO]?
}

struct ResultsDTO: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}
