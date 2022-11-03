//
//  SearchRecipieViewModel.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import UIKit
import Combine

final class SearchRecipieViewModel {
    @Published public var keyWordInput: String = ""
    @Published public private(set) var sections: [CustomCellSection]?
    var errorClosure: (() -> Void)?
    var finishLoad: (() -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    private (set) var recipies: [Recipie] = []
    private var recipieSearchRepository: RecipieSearchRepository
    
    init(recipieSearchRepository: RecipieSearchRepository) {
        self.recipieSearchRepository = recipieSearchRepository
        setupBinder()
    }

    private func setupBinder() {
        $keyWordInput
            .dropFirst()
            .sink( receiveValue: searchForKeyWord(_:))
            .store(in: &subscriptions)
    }

    private func searchForKeyWord(_ keyWord: String) {
        recipieSearchRepository.search(keyWord)
            .sink(receiveCompletion: { [weak self] (error) in
                switch error {
                case .failure(_):
                    if let errorClosure = self?.errorClosure {
                        errorClosure()
                    }
                case .finished:
                    break
                }
            },
                  receiveValue: { [weak self] recipieList in
                self?.updateRecipies(recipieList.results)
            })
            .store(in: &subscriptions)
    }

    private func updateRecipies(_ recipiesResult: [Recipie]) {
        self.recipies = recipiesResult
        self.sections = RecipieCellProvider(recipies: self.recipies).provide()
    }

    func searchRecipieById(recipieId: Int) -> Recipie? {
        return recipies.first { recipie in
            recipie.id == recipieId
        }
    }

    func didTapRecipie(_ index: Int, from view: UIViewController) {
        recipieSearchRepository.searchRecipieDetail(String(index))
            .sink(receiveCompletion: { [weak self] (error) in
                switch error {
                case .failure(_):
                    if let errorClosure = self?.errorClosure {
                        errorClosure()
                    }
                case .finished:
                    if let finishLoad = self?.finishLoad {
                        finishLoad()
                    }
                }
            }
                  , receiveValue: { [weak self] detail in
                self?.presentDetailView(with: detail, from: view)
            })
            .store(in: &subscriptions)
    }

    func presentDetailView(with detail: RecipieDetail, from view: UIViewController) {
        let viewModel = RecipieDetailViewModel(recipeDetail: detail)
        let recipieDetailViewController = RecipieDetailViewController(viewModel: viewModel)
            view.present(recipieDetailViewController, animated: true)
    }
}
