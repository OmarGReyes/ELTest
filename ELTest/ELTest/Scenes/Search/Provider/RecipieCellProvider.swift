//
//  RecipieCellProvider.swift
//  ELTest
//
//  Created by Omar Gonzalez on 31/10/22.
//

import Foundation

final class RecipieCellProvider {
    // MARK: - Properties
    var recipies: [Recipie]
    
    init(recipies: [Recipie]) {
        self.recipies = recipies
    }
    
    private func provideRecipieSection() -> CustomCellSection {
        let items: [DataCellViewModable] = recipies.map { recipie in
            RecipieCellModel(reuseIdentifier: RecipieCell.reuseIdentifier, recipie: recipie)
        }
        
        return CustomCellSection(title: "Recipies", items: items)
    }
    
    func provide() -> [CustomCellSection] {
        return [provideRecipieSection()]
    }
}
