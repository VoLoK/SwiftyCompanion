//
//  TokenRequest.swift
//  Swifty
//
//  Created by Clothor- on 11/13/21.
//

struct TokenRequest: Encodable, Equatable {
    let uid: String
    let secret: String
    let type: String
    
    init(uid: String, secret: String, type: String = "client_credentials") {
        self.uid = uid
        self.secret = secret
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case uid = "client_id"
        case secret = "client_secret"
        case type = "grant_type"
    }
}

