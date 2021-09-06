//
//  NotViewedCellViewModel.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 15.07.2021.
//

import Foundation

protocol VerticalCellViewModelType: AnyObject {
    var image: Box<Data?> { get }
    var name: String { get }
    var nameEn: String { get }
    var year: String { get }
    var genre: String { get }
    var country: String { get }
    var raiting: String { get }
}

var verticalImageCache = NSCache<NSString, NSData>()

class VerticalCellViewModel: VerticalCellViewModelType {
    
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
    
    var year: String {
        return "Год: " + (film.year ?? "")
    }
    
    var genre: String {
        var genres = "Жанр:"
        film.genres?.forEach { genres += " \($0.genre)"}
        return genres
    }
    
    var country: String {
        var countres = "Страна:"
        film.countries?.forEach { countres += " \($0.country)"}
        return countres
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
