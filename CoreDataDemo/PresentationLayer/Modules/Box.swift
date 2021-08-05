//
//  Box.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 19.07.2021.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func binde(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
