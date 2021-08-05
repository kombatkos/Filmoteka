//
//  DetailSectionHeader.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 04.08.2021.
//

import UIKit

protocol DetailSectionHeaderViewModelType {
    var image: Box<Data?> { get }
}

class DetailSectionHeader: UICollectionReusableView {
    
    static let reuseId = "DetailSectionHeader"

    var posterImageView = UIImageView()
    var newLeading: NSLayoutConstraint?
    
    var viewModel: DetailSectionHeaderViewModelType? {
        willSet {
            guard let newModel = newValue else { return }
            newModel.image.binde {
                guard let data = $0, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.posterImageView.image = image
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(posterImageView)
        
        let leading = posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        newLeading = leading
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            newLeading ?? leading
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
