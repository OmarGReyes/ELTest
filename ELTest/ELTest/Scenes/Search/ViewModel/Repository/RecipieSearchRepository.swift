//
//  RecipieSearchRepository.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Foundation
import Combine

final class RecipieSearchRepository: SearchRepository {
    // MARK: - Properties
    private var recipieSearchRequest: RecipiesSearchRequest
    private var recipieDetailSearchRequest: RecipieDetailSearchRequest
    private var recipieNetworkManager: RecipieNetworkManager
    
    // MARK: Initializer
    init(recipieSearchRequest: RecipiesSearchRequest,
         recipieNetworkManager: RecipieNetworkManager,
         recipieDetailSearchRequest: RecipieDetailSearchRequest) {
        self.recipieSearchRequest = recipieSearchRequest
        self.recipieNetworkManager = recipieNetworkManager
        self.recipieDetailSearchRequest = recipieDetailSearchRequest
    }
    
    // MARK: - Search
    func search(_ keyWord: String) -> AnyPublisher<RecipieList, Error> {
        recipieSearchRequest.keyWord = keyWord
        let request = try! recipieSearchRequest.createUrlRequest()
        return recipieNetworkManager.search(request)
    }
    
    func searchRecipieDetail(_ recipieId: String) -> AnyPublisher<RecipieDetail, Error> {
        recipieDetailSearchRequest.recipieId = recipieId
        let request = try! recipieDetailSearchRequest.createUrlRequest()
        return recipieNetworkManager.getRecipieDetail(request)
    }
}
