//
//  KinopoiskInfo.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 22.07.2021.
//

import Foundation

struct KinopoiskInfo: Decodable {
    var data: InfoModel
}

struct InfoModel: Decodable, Hashable {
    var filmId: Int?
    var nameRu: String?
    var nameEn: String?
    var year: Int?
    var filmLength: String?
    var countries: [CountriesInfo]?
    var genres: [GenresInfo]?
    var rating: String?
    var ratingAgeLimits: Int?
    var posterUrl: String?
    var posterUrlPreview: String?
    var slogan: String?
    var description: String?
    var premiereRu: String?
    var premiereWorld: String?
    var distributors: String?
    var distributorRelease: String?
}

struct CountriesInfo: Decodable, Hashable {
    var country: String
}

struct GenresInfo: Decodable, Hashable {
    var genre: String
}
