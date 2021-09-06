//
//  YoutubeViewAdapter.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 09.08.2021.
//

import UIKit
import YouTubePlayer

class YoutubeViewAdapter: UIView {
    
    let youtubeView = YouTubePlayerView()
    
    private var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(youtubeView)
        youtubeView.frame = CGRect(x: -170, y: -50, width: bounds.width + 340, height: bounds.height + 100)
        youtubeView.isUserInteractionEnabled = false
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        youtubeView.frame = CGRect(x: -170, y: -50, width: bounds.width + 340, height: bounds.height + 100)
        gradientLayer.frame = bounds
        clipsToBounds = true
    }
    
    private func setupGradient() {
        layer.addSublayer(gradientLayer)
        setupGradientColor()
    }
    
    private func setupGradientColor() {
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.systemBackground.cgColor]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupGradientColor()
    }
}
