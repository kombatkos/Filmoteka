//
//  Request.swift
//  MyChat
//
//  Created by Konstantin Porokhov on 21.04.2021.
//

import Foundation

enum TypeOfTop: String {
    case best = "TOP_250_BEST_FILMS",
         popular = "TOP_100_POPULAR_FILMS",
         await = "TOP_AWAIT_FILMS"
}

class KinopoiskRequest: IRequest {
    
    private let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/"
    private var page: Int
    private var typeOfTop: String
    
    private var url: String {
        let parameters = "top?type=\(typeOfTop)&page=\(page)"
        return urlString + parameters
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.addValue("0be70525-c729-4258-9e41-c67182e7d835", forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    init(page: Int, typeOfTop: TypeOfTop) {
        self.page = page
        self.typeOfTop = typeOfTop.rawValue
    }
}

