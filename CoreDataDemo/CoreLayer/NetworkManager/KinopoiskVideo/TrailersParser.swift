//
//  TrailersParser.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 18.07.2021.
//

import Foundation

class TrailersParser: IParser {
    
    typealias Model = Trailers
    
    func parse(data: Data) -> Model? {
        do {
            return try JSONDecoder().decode(Model.self, from: data)
        } catch {
            print(NetworkError.notModel.localizedDescription)
            return nil
        }
    }
}
