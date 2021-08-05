//
//  DetailNonViewerViewControllerViewModel.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 15.07.2021.
//

import Foundation

class DetailViewControllerViewModel: DetailViewControllerViewModelType {
    
    private var kinopoiskService: IStocksService
    private var filmID: Int
    
    var urlString: Box<String?> = Box(nil)
    var name: Box<String?> = Box(nil)
    var about: Box<String?> = Box(nil)
    var slogan: Box<String?> = Box(nil)
    
    init(kinopoiskService: IStocksService, filmID: Int) {
        self.kinopoiskService = kinopoiskService
        self.filmID = filmID
        
        kinopoiskService.getFilm(filmID: filmID) { [weak self] result in
            print(filmID)
            switch result {
            case .success(let trailers):
                let trailer = trailers?.trailers?.first
                self?.urlString.value = trailer?.url
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        kinopoiskService.getInfo(filmID: filmID) { [weak self] result in
            switch result {
            case .success(let info):
                self?.name.value = info?.data.nameRu
                self?.about.value = info?.data.description
                self?.slogan.value = info?.data.slogan
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
