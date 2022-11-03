//
//  APIManagerProtocol.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Combine
import Foundation

protocol APIManagerProtocol {
    func perform(_ session: URLSession, request: URLRequest) -> URLSession.DataTaskPublisher
}

extension APIManagerProtocol {
    func perform(_ session: URLSession, request: URLRequest) -> URLSession.DataTaskPublisher {
        return session.dataTaskPublisher(for: request)
    }
}

class APIManager: APIManagerProtocol {}
