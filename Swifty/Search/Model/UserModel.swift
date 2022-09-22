//
//  UserModel.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

import Foundation

struct UserModel: Decodable, Equatable {
    let id: Int
    let email: String
    let login: String
    let firstName: String
    let lastName: String
    let usualFullName: String
    let usualFirstName: String?
    let url: URL
    let phone: String
    let displayName: String
    let imageURL: URL
    let staff: Bool
    let correctionPoint: Int
    let poolMonth: String?
    let poolYear: String?
    let location: String?
    let wallet: Int
    let alumni: Bool
    let cursusUsers: [CursusModel]
    let projectsUsers: [ProjectsUsers]
    let achievements: [AchievementsModel]
    let campus: [CampusModel]
    let campusUsers: [CampusUsersModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case login
        case firstName = "first_name"
        case lastName = "last_name"
        case usualFullName = "usual_full_name"
        case usualFirstName = "usual_first_name"
        case url
        case phone
        case displayName = "displayname"
        case imageURL = "new_image_url"
        case staff = "staff?"
        case correctionPoint = "correction_point"
        case poolMonth = "pool_month"
        case poolYear = "pool_year"
        case location
        case wallet
        case alumni = "alumni?"
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
        case achievements
        case campus
        case campusUsers = "campus_users"
    }
}
