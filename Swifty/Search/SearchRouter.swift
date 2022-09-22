//
//  SearchRouter.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

import Foundation

// MARK: - SearchRoutingLogic

protocol SearchRoutingLogic: AnyObject {
    func routeToUserProfile(model: UserProfileViewModel)
}

// MARK: - SearchRouter

final class SearchRouter: SearchRoutingLogic {
    weak var viewController: SearchViewController?
    
    func routeToUserProfile(model: UserProfileViewModel) {
        guard let viewController = viewController else { return }
        let userProfile = UserProfileFactory(model: model).build()
        viewController.navigationController?.pushViewController(userProfile, animated: true)
    }
}
