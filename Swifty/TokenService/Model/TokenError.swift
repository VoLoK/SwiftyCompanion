//
//  TokenError.swift
//  Swifty
//
//  Created by Clothor- on 11/13/21.
//

struct TokenError: Decodable, Equatable {
    let error: String
    let message: String
}
