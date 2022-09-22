//
//  ProjectsModel.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

struct ProjectsUsers: Decodable, Equatable {
    let id: Int
    let occurrence: Int
    let finalMark: Int?
    let status: String
    let validated: Bool?
    let currentTeamID: Int?
    let project: ProjectModel
    let cursusIDs: [Int]
    let marked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case occurrence
        case finalMark = "final_mark"
        case status
        case validated = "validated?"
        case currentTeamID = "current_team_id"
        case project
        case cursusIDs = "cursus_ids"
        case marked
    }
    
    struct ProjectModel: Decodable, Equatable {
        let id: Int
        let name: String
        let slug: String
        let parentID: Int?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case slug
            case parentID = "parent_id"
        }
    }
}
