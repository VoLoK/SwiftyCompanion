//
//  CampusModel.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

import Foundation

struct CampusModel: Decodable, Equatable {
    let id: Int
    let name: String
    let language: LanguageModel
    let usersCount: Int
    let vogsphereID: Int
    let country: String
    let address: String
    let zip: String
    let city: String
    let website: String
    let facebook: String?
    let twitter: String?
    let active: Bool
    let emailExtension: String
    let defaultHiddenPhone: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case language
        case usersCount = "users_count"
        case vogsphereID = "vogsphere_id"
        case country
        case address
        case zip
        case city
        case website
        case facebook
        case twitter
        case active
        case emailExtension = "email_extension"
        case defaultHiddenPhone = "default_hidden_phone"
    }
    
    struct LanguageModel: Decodable, Equatable {
        let id: Int
        let name: String
        let identifier: String
    }
}
