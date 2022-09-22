//
//  UserProfileFactory.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

import Foundation
import UIKit

// MARK: - UserProfileFactory

final class UserProfileFactory {
    private let profileViewModel: UserProfileViewModel
    
    required init(model: UserProfileViewModel) {
        self.profileViewModel = model
    }
    
    func build() -> UIViewController {
        let viewController = UserProfileViewController(with: profileViewModel)
        
        return viewController
    }
}

