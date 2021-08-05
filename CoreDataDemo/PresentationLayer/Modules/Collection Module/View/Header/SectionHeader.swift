//
//  SectionHeader.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 22.07.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    var title = UILabel()
    var newLeading: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        let leading = title.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        newLeading = leading
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            newLeading ?? leading
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(text: String, font: UIFont?, textColor: UIColor) {
        title.textColor = textColor
        title.font = font
        title.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
