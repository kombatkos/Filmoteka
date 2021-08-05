//
//  Trailers.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 22.07.2021.
//

import Foundation

struct Trailers: Decodable {
    var trailers: [Trailer]?
}

struct Trailer: Decodable {
    var url: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
}
