//
//  SearchDependecyContainer.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Foundation

final class SearchDepedencyContainer {
    // MARK: - Methods
    // MARK: makeRecipiesSearchRequest
    private func makeRecipieSearchRequest() -> RecipiesSearchRequest {
        return RecipiesSearchRequest()
    }

    private func makeRecipieDetailSearchRequest() -> RecipieDetailSearchRequest {
        return RecipieDetailSearchRequest()
    }

    // MARK: makeRecipiesNetworkManager
    private func makeRecipeNetworkManager() -> RecipieNetworkManager {
        return RecipieNetworkManager()
    }

    // MARK: makeRecipieSearchRepository
    private func makeRecipieSearchRepository() -> RecipieSearchRepository {
        let recipieSearchRequest = makeRecipieSearchRequest()
        let recipieDetailSearchRequest = makeRecipieDetailSearchRequest()
        let recipieNetworkManager = makeRecipeNetworkManager()
        return RecipieSearchRepository(recipieSearchRequest: recipieSearchRequest,
                                       recipieNetworkManager: recipieNetworkManager,
                                       recipieDetailSearchRequest: recipieDetailSearchRequest)
    }

    // MARK: makeRecipieSearchViewModel
    private func makeSearchRecipieViewModel() -> SearchRecipieViewModel {
        let recipieRepository = makeRecipieSearchRepository()
        return SearchRecipieViewModel(recipieSearchRepository: recipieRepository)
    }

    func makeSearchRecipieViewController() -> SearchRecipieViewController {
        return SearchRecipieViewController(viewModel: makeSearchRecipieViewModel())
    }
}
