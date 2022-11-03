//
//  NetworkError.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case someError
    
    var descriptionError: String {
        switch self {
        case .invalidUrl:
            return "invalid URL"
        case .someError:
            return "no connection"
        }
    }
}
