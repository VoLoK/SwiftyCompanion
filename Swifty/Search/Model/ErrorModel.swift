//
//  ErrorModel.swift
//  Swifty
//
//  Created by Clothor- on 11/13/21.
//

import Foundation

enum SearchError: Error {
    case message(String)
    
    var description: String {
        switch self {
        case .message(let message):
            return message
        }
    }
}
