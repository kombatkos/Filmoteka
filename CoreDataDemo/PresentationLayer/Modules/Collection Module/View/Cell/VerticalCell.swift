//
//  CollectionViewCell.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 22.07.2021.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U>(with value: U)
}

class VerticalCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId = "VerticalCell"
    var viewModel: VerticalCellViewModelType? {
        willSet {
            guard let newModel = newValue else { return }
            DispatchQueue.main.async { [unowned self] in
                ruNameLabel?.text = newModel.name
                enNameLabel?.text = newModel.nameEn
                ratingLabel?.text = newModel.raiting
                yearLabel?.text = newModel.year
                genreLabel?.text = newModel.genre
                countryLabel?.text = newModel.country
            }
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var ruNameLabel: UILabel?
    @IBOutlet weak var enNameLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var yearLabel: UILabel?
    @IBOutlet weak var genreLabel: UILabel?
    @IBOutlet weak var countryLabel: UILabel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView?.layer.cornerRadius = 5
        posterImageView?.clipsToBounds = true
        
        viewModel?.image.binde {
            guard let data = $0, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.posterImageView?.image = image
            }
        }
    }
    
    func configure<U>(with value: U) {
        guard let viewModel = value as? VerticalCellViewModelType else { return }
        self.viewModel = viewModel
    }
}
