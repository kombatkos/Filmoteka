//
//  TrailersRequest.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 18.07.2021.
//

import Foundation

class TrailersRequest: IRequest {
    
    private let filmId: Int
    
    init(filmId: Int) {
        self.filmId = filmId
    }
    
    private var url: String {
        return "https://kinopoiskapiunofficial.tech/api/v2.1/films/\(filmId)/videos"
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: self.url) else { return nil }
        var request = URLRequest(url: url)
        request.addValue("0be70525-c729-4258-9e41-c67182e7d835", forHTTPHeaderField: "X-API-KEY")
        return request
    }
}
