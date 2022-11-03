//
//  FavoritesViewModel.swift
//  ELTest
//
//  Created by Omar Gonzalez on 31/10/22.
//

import UIKit

final class FavoritesViewModel {
    // MARK: - Properties
    @Published public private(set) var sections: [CustomCellSection]?
    
    private var recipies: [Recipie] {
        didSet {
            updateSections()
        }
    }

    init(recipies: [Recipie]) {
        self.recipies = recipies
    }

    // MARK: deleteSong
    func deleteRecipie(recipieId: Int) {
        self.recipies = recipies.filter { recipie  in
            recipie.id != recipieId
        }
    }

    private func addRecipieToFavorite(recipie: Recipie) {
        self.recipies.append(recipie)
    }

    // MARK: updateSections
    private func updateSections() {
        sections = RecipieCellProvider(recipies: recipies).provide()
    }

    private func shouldAddRecipieToFavorites(recipieToAdd: Recipie) -> Bool {
        for recipie in recipies {
            if recipie.id == recipieToAdd.id {
                return false
            }
        }
        return true
    }

    func didTapRecipie(_ index: Int, from view: UIViewController) {
        
    }
}

extension FavoritesViewModel: SearchRecipieViewControllerDelegate {
    func addRecipieToFavorites(recipie: Recipie) {
        if shouldAddRecipieToFavorites(recipieToAdd: recipie) {
            self.addRecipieToFavorite(recipie: recipie)
        }
    }
}
