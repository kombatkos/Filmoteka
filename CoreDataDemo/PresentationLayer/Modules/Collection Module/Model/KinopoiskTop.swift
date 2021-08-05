//
//  KinopoiskTop.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 22.07.2021.
//

import Foundation

struct KinopoiskTop: Decodable {
    var pagesCount: Int
    var films: [FilmModel]
}

struct FilmModel: Decodable {
    
    var filmId: Int?
    var nameRu: String?
    var nameEn: String?
    var year: String?
    var filmLength: String?
    var countries: [Countries]?
    var genres: [Genres]?
    var rating: String?
    var ratingVoteCount: Int?
    var posterUrl: String?
    var posterUrlPreview: String?
}

extension FilmModel: Hashable {
    func hash(into hasher: inout Hasher) {
        filmId?.hash(into: &hasher)
        nameRu?.hash(into: &hasher)
    }
}

struct Countries: Decodable, Hashable {
    var country: String
}

struct Genres: Decodable, Hashable {
    var genre: String
}
