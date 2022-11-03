//
//  SearchRepository.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import Foundation
import Combine

protocol SearchRepository {
    func search(_ song: String) -> AnyPublisher<RecipieList, Error>
}
