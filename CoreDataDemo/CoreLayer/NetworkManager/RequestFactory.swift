//
//  RequestFactory.swift
//  MyChat
//
//  Created by Konstantin Porokhov on 21.04.2021.
//

import Foundation

struct RequestFactory {
    
    struct KinopoiskRequests {
        
        static func searchFilms(page: Int, typeOfTop: TypeOfTop) -> RequestConfig<KinopoiskParser> {
            let request = KinopoiskRequest(page: page, typeOfTop: typeOfTop)
            let parser = KinopoiskParser()
            
            return RequestConfig<KinopoiskParser>(request: request, parser: parser)
        }
        
        static func getTrailer(filmId: Int) -> RequestConfig<TrailersParser> {
            let request = TrailersRequest(filmId: filmId)
            let parser = TrailersParser()
            
            return RequestConfig<TrailersParser>(request: request, parser: parser)
        }
        
        static func getInfo(filmId: Int) -> RequestConfig<KinopoiskInfoParser> {
            let request = KinopoiskInfoRequest(filmId: filmId)
            let parser = KinopoiskInfoParser()
            
            return RequestConfig<KinopoiskInfoParser>(request: request, parser: parser)
        }
    }
    
}
