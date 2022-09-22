//
//  CampusUsersModel.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

struct CampusUsersModel: Decodable, Equatable {
    let id: Int
    let userID: Int
    let campusID: Int
    let isPrimart: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case campusID = "campus_id"
        case isPrimart = "is_primary"
    }
}
