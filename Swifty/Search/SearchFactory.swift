//
//  SearchFactory.swift
//  Swifty
//
//  Created by Clothor- on 11/1/21.
//

import UIKit

// MARK: - SearchFactory

final class SearchFactory {
    private let tokenService: TokenServiceProtocol

    required init(tokenService: TokenServiceProtocol) {
        self.tokenService = tokenService
    }

    func build() -> UIViewController {
        let router = SearchRouter()
        let presenter = SearchPresenter(router: router)
        let interactor = SearchInteractor(tokenService: tokenService, presenter: presenter)
        let viewController = SearchViewController(interactor: interactor)
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
