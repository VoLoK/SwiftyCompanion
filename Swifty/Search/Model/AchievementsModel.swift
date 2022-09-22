//
//  AchievementsModel.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

import Foundation

struct AchievementsModel: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let tier: String
    let kind: String
    let visible: Bool
    let image: URL
    let nbrOfSuccess: Int?
    let usersURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case tier
        case kind
        case visible
        case image
        case nbrOfSuccess = "nbr_of_success"
        case usersURL = "users_url"
    }
}
