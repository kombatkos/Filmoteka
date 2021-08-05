//
//  StocksService.swift
//  MyStocks
//
//  Created by Konstantin Porokhov on 08.07.2021.
//

import Foundation

protocol IStocksService {
    func getFilms(categoryFilms: CategoryFilms, completion: @escaping (Result<KinopoiskTop?, Error>) -> Void)
    func getFilm(filmID: Int, completion: @escaping (Result<Trailers?, Error>) -> Void)
    func getInfo(filmID: Int, completion: @escaping (Result<KinopoiskInfo?, Error>) -> Void)
}

class StocksService: IStocksService {
    
    private let requestSender: IRequestSender?
    
    init(requestSender: IRequestSender?) {
        self.requestSender = requestSender
    }
    
    func getFilms(categoryFilms: CategoryFilms, completion: @escaping (Result<KinopoiskTop?, Error>) -> Void) {
        var typeOfTop: TypeOfTop
        switch categoryFilms {
        case .topFilms:
            typeOfTop = .best
        case .popularFilms:
            typeOfTop = .popular
        }
        let config = RequestFactory.KinopoiskRequests.searchFilms(page: 1, typeOfTop: typeOfTop)
        requestSender?.send(config: config) { result in
            switch result {
            case .success(let films):
                completion(.success(films))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFilm(filmID: Int, completion: @escaping (Result<Trailers?, Error>) -> Void) {
        let config = RequestFactory.KinopoiskRequests.getTrailer(filmId: filmID)
        requestSender?.send(config: config) { result in
            switch result {
            case .success(let trailer):
                completion(.success(trailer))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getInfo(filmID: Int, completion: @escaping (Result<KinopoiskInfo?, Error>) -> Void) {
        let config = RequestFactory.KinopoiskRequests.getInfo(filmId: filmID)
        requestSender?.send(config: config) { result in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
