//
//  ServiceAssembly.swift
//  MyStocks
//
//  Created by Konstantin Porokhov on 08.07.2021.
//

import Foundation

protocol IServiceAssembly {
    var stocksService: IStocksService { get }
}

class ServiceAssembly: IServiceAssembly {
    let coreAssembly: ICoreAssembly = CoreAssembly()
    
    lazy var stocksService: IStocksService = StocksService(requestSender: coreAssembly.requestSender)
}
