//
//  TokenService.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

import Foundation
import PromiseKit
import Alamofire

protocol TokenServiceProtocol: AnyObject {
    func getToken(completion: @escaping (String?, Error?) -> Void)
}

final class TokenService: TokenServiceProtocol {
    
    private let UID : String = "YOUR TOKEN HERE"
    private let SECRET : String = "YOUR TOKEN HERE"
    private let endpoint : String = "https://api.intra.42.fr"

    private var token: Token?
    private var tokenExpiredTime: TimeInterval = TimeInterval.infinity
    
    func getToken(completion: @escaping (String?, Error?) -> Void) {
        let currectTime = Date().timeIntervalSince1970
        if let token = token,
           currectTime <= tokenExpiredTime {
            completion(token.accessToken, nil)
        } else {
            requestToken { completion($0?.accessToken, $1) }
        }
    }
    
    private func requestToken(completion: @escaping (Token?, Error?) -> Void) {
        firstly {
            fetchToken()
        }.done { [weak self] token in
            guard let self = self else { return }
            self.token = token
            self.tokenExpiredTime = Double(token.createdAt + token.expiredIn)
            completion(token, nil)
        }.catch { error in
            completion(nil, error)
        }
    }
    
    private func fetchToken() -> Promise<Token> {
        return Promise { seal in
            let tokenURL = endpoint.appending("/oauth/token")
            let requestParapeters = TokenRequest(uid: UID, secret: SECRET)
            
            AF.request(tokenURL, method: .post, parameters: requestParapeters)
                .validate()
                .responseJSON { response in
                print(response)
                switch response.result {
                case .success:
                    guard let data = response.data else { return seal.reject(SearchError.message("Error data")) }
                    if let token = try? JSONDecoder().decode(Token.self, from: data) {
                        seal.fulfill(token)
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
}
