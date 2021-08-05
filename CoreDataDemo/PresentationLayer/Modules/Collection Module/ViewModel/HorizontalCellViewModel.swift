//
//  HorizontalCellViewModel.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 03.08.2021.
//

import Foundation

protocol HorizontalCellViewModelType: AnyObject {
    var image: Box<Data?> { get }
    var name: String { get }
    var nameEn: String { get }
    var genre: String { get }
    var raiting: String { get }
}

var horizontalImageCache = NSCache<NSString, NSData>()

class HorizontalCellViewModel: HorizontalCellViewModelType {
    
    private var film: FilmModel
    
    var name: String {
        return film.nameRu ?? ""
    }
    var nameEn: String {
        return film.nameEn ?? ""
    }
    
    var raiting: String {
        return film.rating ?? ""
    }
    
    var genre: String {
        return film.genres?.first?.genre ?? ""
    }
    
    var image: Box<Data?> = Box(nil)
    
    init(film: FilmModel) {
        self.film = film
        DispatchQueue.global().async {
            self.fetchImageData(film)
        }
    }
    
    private func fetchImageData(_ film: FilmModel) {
        guard let urlString = film.posterUrlPreview,
              let url = URL(string: urlString) else { return }
        
        if let cacheImage = verticalImageCache.object(forKey: urlString as NSString) {
            image.value = cacheImage as Data
        } else {
            guard let data = NSData(contentsOf: url) else { return }
            verticalImageCache.setObject(data, forKey: urlString as NSString)
            image.value = data as Data?
        }
    }
}
