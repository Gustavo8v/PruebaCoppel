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
