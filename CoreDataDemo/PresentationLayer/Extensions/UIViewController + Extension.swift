//
//  UIViewController + Extension.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 29.07.2021.
//

import UIKit

extension UIViewController {
    
    func configure<T: SelfConfiguringCell, U>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
        cell.configure(with: value)
        return cell
    }
}
