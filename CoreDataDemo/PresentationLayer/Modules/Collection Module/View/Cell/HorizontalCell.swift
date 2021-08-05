//
//  TopFilmCell.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 29.07.2021.
//

import UIKit

class HorizontalCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId = "HorizontalCell"
    
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var bageView: UIView?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var nameEnLabel: UILabel?
    @IBOutlet weak var genreLabel: UILabel?
    
    weak var viewModel: HorizontalCellViewModelType? {
        willSet {
            DispatchQueue.main.async { [unowned self] in
                guard let newModel = newValue else { return }
                genreLabel?.text = newModel.genre
                nameEnLabel?.text = newModel.nameEn
                nameLabel?.text = newModel.name
                ratingLabel?.text = newModel.raiting
                viewModel?.image.binde {
                    guard let data = $0, let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async { [weak self] in
                        self?.posterImageView?.image = image
                    }
                }
                setupBage(rating: newModel.raiting)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView?.layer.cornerRadius = 5
        posterImageView?.clipsToBounds = true
        bageView?.layer.cornerRadius = 3
        bageView?.clipsToBounds = true
    }
    
    func configure<U>(with value: U) {
        guard let viewModel = value as? HorizontalCellViewModelType else { return }
        self.viewModel = viewModel
    }
    
    func setupBage(rating: String) {
        guard let rating = Double(rating) else { return }
        if rating > 7 {
            bageView?.backgroundColor = .systemGreen
        } else if rating >= 5 {
            bageView?.backgroundColor = .systemYellow
        } else {
            bageView?.backgroundColor = .systemRed
        }
    }
}
