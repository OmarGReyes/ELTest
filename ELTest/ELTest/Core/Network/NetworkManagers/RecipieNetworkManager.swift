//
//  RecipiesNetworkManager.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Foundation
import Combine

fileprivate protocol SearchNetworkManagerProtocol {
    var apiManager: APIManagerProtocol { get }
    func search(_ request: URLRequest) -> AnyPublisher<RecipieList, Error>
    func getRecipieDetail(_ request: URLRequest) -> AnyPublisher<RecipieDetail, Error>
}

final class RecipieNetworkManager: SearchNetworkManagerProtocol {
    var apiManager: APIManagerProtocol
    private let session: URLSession
    private var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    init() {
        self.session = .init(configuration: .default)
        self.apiManager = APIManager()
    }

    init(session: URLSession, apiManager: APIManagerProtocol) {
        self.session = session
        self.apiManager = apiManager
    }

    func search(_ request: URLRequest) -> AnyPublisher<RecipieList, Error> {
        return apiManager.perform(session, request: request)
            .tryMap { output -> Data in
                return output.data
            }
            .receive(on: RunLoop.main)
            .decode(type: RecipieList.self, decoder: decoder)
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }

    func getRecipieDetail(_ request: URLRequest) -> AnyPublisher<RecipieDetail, Error> {
        return apiManager.perform(session, request: request)
            .tryMap { output -> Data in
                return output.data
            }
            .receive(on: RunLoop.main)
            .decode(type: RecipieDetail.self, decoder: decoder)
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
