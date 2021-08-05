//
//  CoreAssembly.swift
//  MyStocks
//
//  Created by Konstantin Porokhov on 08.07.2021.
//

import Foundation

protocol ICoreAssembly {
    var requestSender: IRequestSender { get }
}

class CoreAssembly: ICoreAssembly {
    
    lazy var requestSender: IRequestSender = RequestSender()
}
