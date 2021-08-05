//
//  KinopoiskInfoParser.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 21.07.2021.
//

import Foundation

class KinopoiskInfoParser: IParser {
    
    typealias Model = KinopoiskInfo
    
    func parse(data: Data) -> Model? {
        do {
            return try JSONDecoder().decode(Model.self, from: data)
        } catch {
            print(NetworkError.notModel.localizedDescription)
            return nil
        }
    }
}
