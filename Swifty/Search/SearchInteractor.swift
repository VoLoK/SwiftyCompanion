//
//  SearchInteractor.swift
//  Swifty
//
//  Created by Clothor- on 11/1/21.
//

import Foundation
import PromiseKit
import Alamofire

// MARK: - SearchBusinessLogic

protocol SearchBusinessLogic: AnyObject {
    func fetchUser(_: String)
}

// MARK: - SearchInteractor

final class SearchInteractor: SearchBusinessLogic {
    private let presenter: SearchPresentationLogic
    private let tokenService: TokenServiceProtocol
    private let endpoint : String = "https://api.intra.42.fr"
    
    required init(tokenService: TokenServiceProtocol, presenter: SearchPresentationLogic) {
        self.tokenService = tokenService
        self.presenter = presenter
    }
    
    func fetchUser(_ user: String) {
        if user.isEmpty {
            self.presenter.presentError()
            return
        }
        
        tokenService.getToken { [weak self] token, error in
            guard let self = self else { return }
            if let token = token {
                firstly {
                    self.findUser(user, token: token)
                }.done { userModel in
                    self.presenter.presentUserProfile(model: userModel)
                }.catch { error in
                    self.errorHandler(error)
                }
            } else if let error = error {
                self.errorHandler(error)
            }
        }
    }

    private func findUser(_ user: String, token: String) -> Promise<UserModel> {
        return Promise { seal in
            let url = endpoint.appending("/v2/users/\(user)")
            let bearer = "Bearer \(token)"
            let headers = HTTPHeaders(["Authorization": bearer])

            AF.request(url, method: .get, headers: headers)
                .validate()
                .responseJSON { response in
                print(response)
                switch response.result {
                case .success:
                    guard let data = response.data else { return seal.reject(SearchError.message("Error data")) }
                    if let userModel = try? JSONDecoder().decode(UserModel.self, from: data) {
                        seal.fulfill(userModel)
                    } else {
                        seal.reject(SearchError.message("JSON could not be encoded because of error"))
                    }
                case .failure:
                    if let data = response.data,
                       let error = try? JSONDecoder().decode(TokenError.self, from: data) {
                        seal.reject(SearchError.message(error.message))
                    } else if let error = response.error {
                        seal.reject(error)
                    }
                }
            }
        }
    }
    
    private func errorHandler(_ error: Error) {
        if let error = error.asAFError {
            if error.responseCode == 404 {
                presenter.presentError()
            } else if error.isInvalidURLError {
                presenter.presentError(message: "Username in not valid.\nPlease try again...")
            } else {
                presenter.presentError(message: error.localizedDescription)
            }
        } else if let error = error as? SearchError {
            presenter.presentError(message: error.description)
        } else {
            presenter.presentError(message: error.localizedDescription)
        }
    }
}
