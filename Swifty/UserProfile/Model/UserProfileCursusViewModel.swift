//
//  UserProfileCursusViewModel.swift
//  Swifty
//
//  Created by Clothor- on 11/13/21.
//

import Foundation

struct UserProfileCursusViewModel: Equatable {
    let userFullName: String
    let login: String
    let joined: String?
    let grade: String?
    let email: String
    let phone: String
    let location: String?
    let points: Int
    let wallet: Int
    let userLevel: String
    let progress: Float
    let skills: [UserProfileSkillsViewModel]
    let cursusID: Int
    let cursusName: String?
}
