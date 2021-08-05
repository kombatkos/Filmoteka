//
//  NonViewedCollectionViewModel.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 22.07.2021.
//

import Foundation

class CollectionViewControllerViewModel: CollectionViewControllerViewModelType {
    
    let kinopoiskService = ServiceAssembly().stocksService
    weak var delegate: INotViewedViewController?
    
    var films: [FilmModel] = [] {
        didSet {
            delegate?.reloadData(topFilm: topFilms, popularFilm: films)
        }
    }
    
    var topFilms: [FilmModel] = [] {
        didSet {
            delegate?.reloadData(topFilm: topFilms, popularFilm: films)
        }
    }
    
    func loadData() {
        
        kinopoiskService.getFilms(categoryFilms: .popularFilms) { [unowned self] result in
            switch result {
            case .success(let kinopoisk):
                self.films = kinopoisk?.films ?? []
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        kinopoiskService.getFilms(categoryFilms: .topFilms) { [unowned self] result in
            switch result {
            case .success(let kinopoisk):
                self.topFilms = kinopoisk?.films ?? []
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func generatedViewModelForDetailVC(indexPath: IndexPath) -> DetailViewControllerViewModelType? {
        
        var filmID: Int?
        switch CategoryFilms(rawValue: indexPath.section) {
        case .topFilms:
            filmID = topFilms[indexPath.row].filmId
        case .popularFilms:
            filmID = films[indexPath.row].filmId
        case .none:
            return nil
        }
        guard filmID != nil else { return nil }
        let detailVCViewModel = DetailViewControllerViewModel(kinopoiskService: kinopoiskService,
                                                              filmID: filmID ?? 0)
        return detailVCViewModel
    }
    
    func generatedViewModelForVerticalCell(_ film: FilmModel) -> VerticalCellViewModelType? {
        return VerticalCellViewModel(film: film)
    }
    
    func generatedViewModelForHorizontalCell(_ film: FilmModel) -> HorizontalCellViewModelType? {
        return HorizontalCellViewModel(film: film)
    }
    
}
