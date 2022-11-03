//
//  FavoritesDependencyContainer.swift
//  ELTest
//
//  Created by Omar Gonzalez on 31/10/22.
//

import Foundation

// MARK: FavoritesDependencyContainer
final class FavoritesDependencyContainer {
    // MARK: - Properties
    private var favoritesViewModel: FavoritesViewModel = FavoritesViewModel(recipies: [])
    
    // MARK: getFavoritesViewModel
    func getFavoritesViewModel() -> FavoritesViewModel {
        favoritesViewModel
    }
    
    func makeFavoritesViewController() -> FavoritesViewController {
        FavoritesViewController(viewModel: getFavoritesViewModel())
    }
}
