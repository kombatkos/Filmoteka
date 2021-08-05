//
//  CategoryFilms.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 03.08.2021.
//

import Foundation

enum CategoryFilms: Int, CaseIterable {
    case  topFilms, popularFilms
    
    func description() -> String {
        switch self {
        case .topFilms:
            return "Top films"
        case .popularFilms:
            return "Popular films"
        }
    }
}
