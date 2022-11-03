//
//  AppDependencyContainer.swift
//  ELTest
//
//  Created by Omar Gonzalez on 28/10/22.
//

import Foundation
import UIKit

final class AppDependencyContainer {
    // MARK: - Properties
    let searchDependencyContainer: SearchDepedencyContainer
    let favoritesDependecyContainer: FavoritesDependencyContainer

    init() {
        self.searchDependencyContainer = SearchDepedencyContainer()
        self.favoritesDependecyContainer = FavoritesDependencyContainer()
    }


    func makeInitialViewController() -> MainViewController {
        let searchViewController = searchDependencyContainer.makeSearchRecipieViewController()
        let favoritesViewController = favoritesDependecyContainer.makeFavoritesViewController()
        searchViewController.delegate = favoritesDependecyContainer.getFavoritesViewModel()
        
        return MainViewController(favoritesViewController: favoritesViewController, searchViewController: searchViewController)
    }
}
