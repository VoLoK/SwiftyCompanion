//
//  Token.swift
//  Swifty
//
//  Created by Clothor- on 11/13/21.
//

struct Token: Decodable, Equatable {
    let accessToken: String
    let createdAt: Int
    let expiredIn: Int
    let scope: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case createdAt = "created_at"
        case expiredIn = "expires_in"
        case scope
        case tokenType = "token_type"
    }
}
