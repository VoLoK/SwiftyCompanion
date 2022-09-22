//
//  UserProfileViewModel.swift
//  Swifty
//
//  Created by Clothor- on 11/4/21.
//

import Foundation

struct UserProfileViewModel: Equatable {
    let campus: String
    let profileIconData: Data?
    let staff: Bool
    let cursus: [UserProfileCursusViewModel]
    let projectsUsers: [UserProfileProjectViewModel]
    let achievements: [UserProfileAchievementsViewModel]
}
