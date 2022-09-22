//
//  CursusModel.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

struct CursusModel: Decodable, Equatable {
    let grade: String?
    let level: Double
    let skills: [SkillsModel]
    let id: Int
    let cursusID: Int
    let hasCoalition: Bool
    let user: UserModelInside
    let cursus: CursusInfo
    
    enum CodingKeys: String, CodingKey {
        case grade
        case level
        case skills
        case id
        case cursusID = "cursus_id"
        case hasCoalition = "has_coalition"
        case user
        case cursus
    }
    
    struct SkillsModel: Decodable, Equatable {
        let id: Int
        let name: String
        let level: Double
    }
    
    struct CursusInfo: Decodable, Equatable {
        let id: Int
        let name: String
        let slug: String
    }
}

